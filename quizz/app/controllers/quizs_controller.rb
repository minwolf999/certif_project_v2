# frozen_string_literal: true

class QuizsController < ApplicationController
  load_and_authorize_resource

  def index
    @history = @quizzes.joins(:score).where(score: { user_id: current_user.id })
  end
end
