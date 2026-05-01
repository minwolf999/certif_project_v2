# frozen_string_literal: true

class QuestionsController < ApplicationController
  def new
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to new_quiz_path }
    end
  end
end
