# frozen_string_literal: true

module Notification
  class ToasterComponent < ApplicationComponent

    attr_reader :notif_type, :message

    def initialize(notif_type:, message:)
      @notif_type = notif_type
      @message = message
    end

    def render?
      message.present?
    end

    def background_class
      case notif_type
      when 'success'
        'bg-green-50'
      when 'info'
        'bg-blue-50'
      when 'error'
        'bg-red-50'
      when 'warning'
        'bg-yellow-50'
      else
        'bg-white'
      end
    end

    def text_class
      case notif_type
      when 'success'
        'text-green-800'
      when 'info'
        'text-blue-800'
      when 'error'
        'text-red-800'
      when 'warning'
        'text-yellow-800'
      else
        'text-gray-900'
      end
    end
  end
end
