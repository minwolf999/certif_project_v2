# frozen_string_literal: true

module Answers
  module New
    class Component < ApplicationComponent
      def initialize(form:, answer:)
        @form = form
        @answer = answer
      end
    end
  end
end
