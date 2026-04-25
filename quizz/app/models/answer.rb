# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id         :bigint           not null, primary key
#  good?      :boolean          not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quiz_id    :bigint           not null
#
# Indexes
#
#  index_answers_on_quiz_id  (quiz_id)
#
# Foreign Keys
#
#  fk_rails_...  (quiz_id => quizzes.id)
#
class Answer < ApplicationRecord
  belongs_to :quiz
end
