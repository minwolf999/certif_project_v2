# frozen_string_literal: true

module Common
  module LikeDislike
    class Component < ApplicationComponent
      include InlineSvg::ActionView::Helpers

      def initialize(quiz:)
        @quiz = quiz
      end
    end
  end
end
