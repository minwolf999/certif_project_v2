# frozen_string_literal: true

class CreateScores < ActiveRecord::Migration[7.2]
  def change
    create_table :scores do |t|
      t.float :point, default: 0
      t.bigint :user_id, null: false

      t.references :quiz, null: false, foreign_key: true
      t.timestamps
    end
  end
end
