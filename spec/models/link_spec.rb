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

  describe "#popularity" do
    let(:up_votes_count) { rand(0..100) }
    let(:down_votes_count) { rand(0..100) }
    before do
      link.up_votes_count = up_votes_count
      link.down_votes_count = down_votes_count
    end
    it "should return the link's up vote count - down vote count" do
      expect(link.popularity).to eq(up_votes_count - down_votes_count)
    end
  end

  describe "::by_popularity" do
    let!(:most_popular) { create(:link) }
    let!(:least_popular) { create(:link) }
    let!(:regular) { create(:link) }
    let!(:newest) { create(:link) }
    before do
      most_popular.update_attributes!(up_votes_count: 10, down_votes_count: 3)
      least_popular.update_attributes!(up_votes_count: 3, down_votes_count: 5)
    end
    it "should order first by popularity, then by created date" do
      expect(Link.by_popularity.to_a).to eq(
        [most_popular, newest, regular, least_popular]
      )
    end
  end
end
