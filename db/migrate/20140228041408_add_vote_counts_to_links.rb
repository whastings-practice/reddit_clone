class AddVoteCountsToLinks < ActiveRecord::Migration
  def change
    add_column :links, :up_votes_count, :integer, default: 0
    add_column :links, :down_votes_count, :integer, default: 0
    add_index :links, :up_votes_count
    add_index :links, :down_votes_count
  end
end
