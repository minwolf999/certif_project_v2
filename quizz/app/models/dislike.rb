# == Schema Information
#
# Table name: dislikes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  quiz_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_dislikes_on_quiz_id  (quiz_id)
#
# Foreign Keys
#
#  fk_rails_...  (quiz_id => quizzes.id)
#
class Dislike < ApplicationRecord
  belongs_to :quiz
end
