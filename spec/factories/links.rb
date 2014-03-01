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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    title "MyString"
    url "MyString"
    description "MyText"
    user_id 1
    up_votes_count 0
    down_votes_count 0
  end
end
