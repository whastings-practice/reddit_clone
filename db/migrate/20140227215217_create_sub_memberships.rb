class CreateSubMemberships < ActiveRecord::Migration
  def change
    create_table :sub_memberships do |t|
      t.integer :link_id, null: false
      t.integer :sub_id, null: false

      t.timestamps
    end
    add_index :sub_memberships, :link_id
    add_index :sub_memberships, :sub_id
  end
end
