# frozen_string_literal: true

class CreateQuizzes < ActiveRecord::Migration[7.2]
  def change
    create_table :quizzes do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.bigint :user_id, null: false

      t.timestamps
    end
  end
end
