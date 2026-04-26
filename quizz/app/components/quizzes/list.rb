# frozen_string_literal: true

module Quizzes
  class List < ApplicationComponent
    def initialize(quizs:)
      @quizs = quizs
    end
  end
end
