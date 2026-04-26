# frozen_string_literal: true

class QuizzesController < ApplicationController
  load_and_authorize_resource

  def index
    @history = @quizzes.joins(:scores).where(scores: { user_id: current_user.id })

    respond_to do |format|
      format.html
      format.turbo_stream { render layout: false }
    end
  end

  def new; end

  def create
    debugger

    redirect_to quizzes_path
  end
end
