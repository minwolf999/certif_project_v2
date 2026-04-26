# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  score      :integer          default(1)
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quiz_id    :bigint           not null
#
# Indexes
#
#  index_questions_on_quiz_id  (quiz_id)
#
# Foreign Keys
#
#  fk_rails_...  (quiz_id => quizzes.id)
#
class Question < ApplicationRecord
  belongs_to :quiz

  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true

  validate :good_answer?

  private

  def good_answer?
    return if answers.any?(&:good) && !answers.all?(&:good)

    errors.add(:answers, t('model.validate.quiz.answers'))
  end
end
