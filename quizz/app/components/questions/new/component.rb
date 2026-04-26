# frozen_string_literal: true

module Questions
  module New
    class Component < ApplicationComponent
      def initialize(form:)
        @form = form
      end
    end
  end
end
