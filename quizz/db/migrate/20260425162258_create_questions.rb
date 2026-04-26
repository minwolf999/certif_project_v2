class CreateQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.integer :score, default: 1

      t.references :quiz, null: false, foreign_key: true

      t.timestamps
    end
  end
end
