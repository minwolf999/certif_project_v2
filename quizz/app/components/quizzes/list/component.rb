# frozen_string_literal: true

module Quizzes
  module List
    class Component < ApplicationComponent
      def initialize(quizzes:)
        @quizzes = quizzes
      end
    end
  end
end
