# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  parent_comment_id :integer
#  user_id           :integer          not null
#  link_id           :integer          not null
#  body              :text             not null
#  created_at        :datetime
#  updated_at        :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    parent_comment_id 1
    user_id 1
    link_id 1
    body "MyText"
  end
end
