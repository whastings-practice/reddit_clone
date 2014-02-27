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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sub_membership do
    link_id 1
    sub_id 1
  end
end
