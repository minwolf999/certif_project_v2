# frozen_string_literal: true

module Questions
  module Show
    class Component < ApplicationComponent
      def initialize(question:)
        @question = question
        @quiz = @question.quiz
        @score = Score.find_by(quiz: @quiz, user_id: Current::User.user.id)
        @current_question_index = @quiz.questions.find_index(@question)
      end
    end
  end
end
