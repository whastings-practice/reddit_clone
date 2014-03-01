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

class LinkVote < ActiveRecord::Base
  UP_VOTE = 1
  DOWN_VOTE = 0

  validates :user_id, :link_id, :direction, presence: true
  validates :user_id, uniqueness: { scope: :link_id }
  validates :direction, inclusion: { in: [UP_VOTE, DOWN_VOTE] }

  belongs_to :user
  belongs_to :link

  def self.record_vote(link_id, user_id, direction)
    attributes = { link_id: link_id, user_id: user_id }
    vote = self.find_by(attributes)
    if vote.nil?
      vote = LinkVote.new(attributes)
    else
      return if vote.direction == direction
      vote.link.decrement!(
        direction == UP_VOTE ? :down_votes_count : :up_votes_count
      )
    end
    vote.direction = direction
    vote.save!
    vote.link.increment!(
      direction == UP_VOTE ? :up_votes_count : :down_votes_count
    )
  end
end
