# frozen_string_literal: true

class QuestionsController < ApplicationController
  load_and_authorize_resource

  def new
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to new_quiz_path }
    end
  end

  def show
    score = @question.quiz.scores.find_or_create_by(user_id: current_user.id)
    return unless @question.quiz.questions.find_index(@question).zero?

    score.update(point: 0.0)
  end

  def answer
    selected_answer = @question.answers.find(params[:answer])

    if selected_answer.good
      score = Score.find_by(quiz: @question.quiz, user_id: current_user.id)
      score.update(point: score.point + @question.score)
    end

    current_question_index = @question.quiz.questions.find_index(@question)
    next_question = @question.quiz.questions[current_question_index + 1]

    if next_question.nil?
      redirect_to result_quiz_path(@question.quiz)
    else
      redirect_to question_path(next_question)
    end
  end
end
