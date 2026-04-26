# frozen_string_literal: true

module Quizzes
  module List
    class Component < ApplicationComponent
      def initialize(quizs:)
        @quizs = quizs
      end
    end
  end
end
