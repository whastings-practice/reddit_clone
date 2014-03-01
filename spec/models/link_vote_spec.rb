# == Schema Information
#
# Table name: link_votes
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  link_id    :integer          not null
#  direction  :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe LinkVote do
  subject(:link_vote) { create(:link_vote) }

  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:link_id) }
    it { should validate_presence_of(:direction) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:link_id) }
    it { should ensure_inclusion_of(:direction).in_array([0, 1]) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:link) }
  end

  describe "::record_vote" do
    let(:user) { create(:user) }
    let(:link) { create(:link) }

    it "sets the vote's direction, user_id, and link_id" do
      LinkVote.record_vote(link.id, user.id, LinkVote::UP_VOTE)
      vote = LinkVote.last
      expect(vote.link_id).to eq(link.id)
      expect(vote.user_id).to eq(user.id)
      expect(vote.direction).to eq(LinkVote::UP_VOTE)
    end

    it "increments the link's up vote count when up voting" do
      expect { LinkVote.record_vote(link.id, user.id, LinkVote::UP_VOTE) }
        .to change { link.reload.up_votes_count }.by(1)
    end

    it "increments the link's down vote count when down voting" do
      expect { LinkVote.record_vote(link.id, user.id, LinkVote::DOWN_VOTE) }
        .to change { link.reload.down_votes_count }.by(1)
    end

    it "updates an existing vote" do
      existing_vote = link.votes.create(
        user_id: user.id,
        direction: LinkVote::UP_VOTE
      )
      expect { LinkVote.record_vote(link.id, user.id, LinkVote::DOWN_VOTE) }
        .to change { link.reload.up_votes_count }.by(-1)
      expect(existing_vote.reload.direction).to eq(LinkVote::DOWN_VOTE)
    end

    it "prevents a user making the same vote twice" do
      expect do
        2.times do
          LinkVote.record_vote(link.id, user.id, LinkVote::UP_VOTE)
        end
      end.to change { link.reload.up_votes_count }.by(1)
    end
  end
end
