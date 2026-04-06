# frozen_string_literal: true

require 'spec_helper'
require 'simplecov'
require "omniauth"
require "omniauth/test"

SimpleCov.start 'rails' do
  add_filter '/bin/'
  add_filter '/db/'
  add_filter '/spec/'
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'active_job/test_helper'

Rails.root.glob('spec/support/**/*.rb').sort.each { |f| require f }

Rails.logger = Logger.new(STDOUT)
Rails.logger.level = Logger::DEBUG
ActiveRecord::Base.logger = Rails.logger
ActiveJob::Base.logger = Rails.logger

class MailLoggerInterceptor
  def self.delivering_email(message)
    puts "📧 Mail envoyé à #{message.to}, sujet: #{message.subject}"
    puts "Body:\n#{message.body.raw_source}"
  end
end
ActionMailer::Base.register_interceptor(MailLoggerInterceptor)

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.include ActiveJob::TestHelper

  config.before(:each, type: :model) do
    ActiveRecord::Base.connection.begin_transaction(joinable: false)
  end

  config.before(:suite) do
    OmniAuth.config.test_mode = true
  end

  config.after(:each, type: :model) do
    ActiveRecord::Base.connection.rollback_transaction
  end

  config.before(:each, type: :feature) do
    ActiveJob::Base.queue_adapter = :inline
    puts "Rails.root = #{Rails.root}"
    puts "tmp/mails path = #{Rails.root.join('tmp/mails')}"
    FileUtils.mkdir_p(Rails.root.join('tmp/mails'))
    puts "dossier existe ? #{Dir.exist?(Rails.root.join('tmp/mails'))}"
    puts "fichiers avant test : #{Dir[Rails.root.join('tmp/mails/*')].inspect}"
    FileUtils.rm_rf(Dir[Rails.root.join('tmp/mails/*')])
    tables = ActiveRecord::Base.connection.tables -
             %w[schema_migrations ar_internal_metadata]
    tables.each do |table|
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table} RESTART IDENTITY CASCADE")
    end
  end

  config.after(:each, type: :feature) do
    begin
      page.execute_script('localStorage.clear(); sessionStorage.clear();')
    rescue StandardError
    end
    Capybara.reset_sessions!
  end

  config.filter_rails_from_backtrace!
end
