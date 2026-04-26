# frozen_string_literal: true

module Quizzes
  module History
    class Component < ApplicationComponent
      def initialize(quizs:)
        @quizs = quizs || []
      end
    end
  end
end
