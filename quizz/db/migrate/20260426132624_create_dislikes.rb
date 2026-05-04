class CreateDislikes < ActiveRecord::Migration[7.2]
  def change
    create_table :dislikes do |t|
      t.bigint :user_id, null: false

      t.references :quiz, null: false, foreign_key: true
      t.timestamps
    end
  end
end
