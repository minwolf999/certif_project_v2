# frozen_string_literal: true

module Quizzes
  module Show
    class Component < ApplicationComponent
      include InlineSvg::ActionView::Helpers

      def initialize(quiz:)
        @quiz = quiz
      end
    end
  end
end
