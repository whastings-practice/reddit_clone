class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title, null: false
      t.string :url, limit: 1024, null: false
      t.text :description
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :links, :user_id
  end
end
