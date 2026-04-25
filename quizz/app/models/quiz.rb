# frozen_string_literal: true

# == Schema Information
#
# Table name: quizzes
#
#  id          :bigint           not null, primary key
#  description :string           not null
#  question    :string           not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
class Quiz < ApplicationRecord
  has_many :answers

  validate :good_answer?

  private

  def good_answer?
    return if answers.any?(&:good?) && !answers.all?(&:good?)

    errors.add(:answers, t('model.validate.quiz.answers'))
  end
end
