# == Schema Information
#
# Table name: scores
#
#  id         :bigint           not null, primary key
#  point      :float            default(0.0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quiz_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_scores_on_quiz_id  (quiz_id)
#
# Foreign Keys
#
#  fk_rails_...  (quiz_id => quizzes.id)
#
class Score < ApplicationRecord
  belongs_to :quiz
end
