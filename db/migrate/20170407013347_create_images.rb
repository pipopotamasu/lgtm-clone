class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :image
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :images, [:user_id, :created_at]
  end
end
