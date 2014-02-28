# == Schema Information
#
# Table name: sub_memberships
#
#  id         :integer          not null, primary key
#  link_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class SubMembership < ActiveRecord::Base
  validates :link, :sub_id, presence: true

  belongs_to :sub
  belongs_to :link
end
