class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.integer :image_id
      t.integer :user_id
      t.boolean :evaluation

      t.timestamps
    end
    add_index :evaluations, :image_id
    add_index :evaluations, :user_id
    add_index :evaluations, [:image_id, :user_id], unique: true
  end
end
