# frozen_string_literal: true

require 'capybara/rspec'

# TO DEBUG WITH FIREFOX OPEN : SET THIS TO FALSE
HEADLESS = false

Capybara.register_server :puma_in_test do |app, port, host|
  require 'rack/handler/puma'
  Rack::Handler::Puma.run(
    app,
    Host: host,
    Port: port,
    Threads: '0:4',
    environment: 'test'
  )
end

Capybara.server = :puma_in_test
Capybara.server_port = 3001
Capybara.app_host = 'http://localhost:3001'

profile = Selenium::WebDriver::Firefox::Profile.new
profile['browser.download.dir'] = Rails.root.join('spec/download/').to_s
profile['browser.download.folderList'] = 2
profile['browser.helperApps.neverAsk.saveToDisk'] = 'text/csv'
profile['intl.accept_languages'] = 'fr'

browser_options = Selenium::WebDriver::Firefox::Options.new
browser_options.args << '--headless' if HEADLESS
browser_options.args << '--width=1920'
browser_options.args << '--height=1080'
browser_options.profile = profile

Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :firefox,
    options: browser_options
  )
end

Capybara.default_driver = :firefox
Capybara.javascript_driver = :firefox
Capybara.current_driver = :firefox
Capybara.default_max_wait_time = 5

def wait_for_turbo(timeout: 30)
  start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

  loop do
    no_streams = begin
      page.evaluate_script("document.querySelectorAll('turbo-stream').length === 0")
    rescue StandardError
      true
    end
    no_busy_frames = begin
      page.evaluate_script("Array.from(document.querySelectorAll('turbo-frame')).every(f => !f.hasAttribute('busy'))")
    rescue StandardError
      true
    end

    break if no_streams && no_busy_frames

    if (Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time) > timeout
      raise Capybara::ExpectationNotMet, 'Turbo ne s\'est pas stabilisé à temps'
    end
  end
end
