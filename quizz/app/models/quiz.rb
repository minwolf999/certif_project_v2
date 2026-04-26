# frozen_string_literal: true

# == Schema Information
#
# Table name: quizzes
#
#  id          :bigint           not null, primary key
#  description :string           not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy
  has_many :scores, dependent: :destroy

  accepts_nested_attributes_for :questions, allow_destroy: true

  def score_for(user)
    user_scores = scores.where(user_id: user.id)
    user_scores.sum(&:point)
  end
end
