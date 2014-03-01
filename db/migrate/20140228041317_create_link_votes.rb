class CreateLinkVotes < ActiveRecord::Migration
  def change
    create_table :link_votes do |t|
      t.integer :user_id, null: false
      t.integer :link_id, null: false
      t.integer :direction, null: false

      t.timestamps
    end
    add_index :link_votes, [:link_id, :user_id], unique: true
    add_index :link_votes, :link_id
    add_index :link_votes, :user_id
  end
end
