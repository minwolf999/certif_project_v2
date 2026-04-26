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

  def new
    question = @quiz.questions.build
    4.times { question.answers.build }
  end

  def create
    @quiz = Quiz.new(create_params)
    @quiz.user_id = current_user.id

    if @quiz.save
      flash[:success] = I18n.t('flash.quizzes.create.success')
      redirect_to quizzes_path
    else
      flash.now[:alert] = @quiz.errors.full_messages.join(',')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:quiz).permit(
      :title,
      :description,
      questions_attributes: [
        :title,
        :score,
        answers_attributes: [
          :title,
          :good
        ]
      ]
    )
  end
end
