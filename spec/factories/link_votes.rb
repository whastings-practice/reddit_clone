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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link_vote do
    user_id 1
    link_id 1
    direction 1
  end
end
