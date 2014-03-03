# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  moderator_id :integer          not null
#  name         :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Sub < ActiveRecord::Base
  validates :name, uniqueness: true
  validates :name, :moderator_id, presence: true

  belongs_to(
    :moderator,
    foreign_key: :moderator_id,
    class_name: "User"
  )

  has_many :sub_memberships
  has_many :links, through: :sub_memberships

  accepts_nested_attributes_for :links, reject_if: :all_blank

  def is_moderator?(user)
    self.moderator.id == user.try(:id)
  end
end
