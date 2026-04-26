# frozen_string_literal: true

module Quizzes
  class History < ApplicationComponent
    def initialize(quizs:)
      @quizs = quizs || []
    end
  end
end
