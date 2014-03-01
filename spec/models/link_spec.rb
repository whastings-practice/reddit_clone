# == Schema Information
#
# Table name: links
#
#  id               :integer          not null, primary key
#  title            :string(255)      not null
#  url              :string(1024)     not null
#  description      :text
#  user_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#  up_votes_count   :integer
#  down_votes_count :integer
#

require 'spec_helper'

describe Link do
  subject(:link) { create(:link) }

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:user_id) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:sub_memberships) }
    it { should have_many(:subs) }
    it { should have_many(:comments) }
    it { should have_many(:votes).class_name('LinkVote') }
  end

  describe "#comments_by_parent_id" do
    let!(:parent1) { create(:comment, parent_comment_id: nil, link_id: link.id) }
    let!(:child1) { create(:comment, parent_comment_id: parent1.id, link_id: link.id) }
    let!(:parent2) { create(:comment, parent_comment_id: nil, link_id: link.id) }
    let!(:child2) { create(:comment, parent_comment_id: parent2.id, link_id: link.id)}

    it "should return all link comments indexed by parent_id" do
      expect(link.comments_by_parent_id[0]).to eq([parent1, parent2])
      expect(link.comments_by_parent_id[parent1.id]).to eq([child1])
      expect(link.comments_by_parent_id[parent2.id]).to eq([child2])
    end
  end
end
