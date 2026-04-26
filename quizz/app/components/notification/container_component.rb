# frozen_string_literal: true

module Notification
  class ContainerComponent < ApplicationComponent
    renders_many :toasters, Notification::ToasterComponent

    def render?
      toasters.any?(&:render?)
    end
  end
end
