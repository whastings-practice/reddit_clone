# == Schema Information
#
# Table name: links
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  url         :string(1024)     not null
#  description :text
#  user_id     :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Link do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:user_id) }
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:sub_memberships) }
    it { should have_many(:subs) }
  end
end
