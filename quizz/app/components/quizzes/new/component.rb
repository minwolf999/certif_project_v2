# frozen_string_literal: true

module Quizzes
  module New
    class Component < ApplicationComponent
      include Turbo::FramesHelper

      def initialize(quiz:)
        @quiz = quiz
        @user = Current::User.user
      end
    end
  end
end
