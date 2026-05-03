# frozen_string_literal: true

module Quizzes
  module Result
    class Component < ApplicationComponent
      include InlineSvg::ActionView::Helpers

      def initialize(quiz:)
        @quiz = quiz
        @score = Score.find_by(quiz: @quiz, user_id: Current::User.user.id)
        @max_score = @quiz.questions.sum(&:score)
      end
    end
  end
end
