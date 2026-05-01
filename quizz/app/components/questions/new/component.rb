# frozen_string_literal: true

module Questions
  module New
    class Component < ApplicationComponent
      def initialize(question)
        @question = question
      end
    end
  end
end
