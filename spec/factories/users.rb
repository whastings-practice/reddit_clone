# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

require 'faker'
FactoryGirl.define do
  factory :user do
    username Faker::Internet.user_name
    password 'foobar'
  end
end
