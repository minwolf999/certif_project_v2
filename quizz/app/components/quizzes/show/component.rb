# frozen_string_literal: true

module Quizzes
  module Show
    class Component < ApplicationComponent
      def initialize(quiz:)
        @quiz = quiz
      end

      private

      def graph_data
        {
          'graph--score-by-user-target': 'canvas',
          'label': t('.score_by_user_label'),
          'x_legend': t('.x_legend'),
          'y_legend': t('.y_legend'),
          'scores': @quiz.scores.to_json
        }
      end
    end
  end
end
