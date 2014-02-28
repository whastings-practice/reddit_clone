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

require 'spec_helper'

describe Comment do
  describe "validations" do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:link_id) }
    it { should validate_presence_of(:body) }
  end

  describe "associations" do
    it { should belong_to :user }
    it { should belong_to :link }
    it { should belong_to(:parent_comment).class_name('Comment') }
    it { should have_many(:child_comments).class_name('Comment') }
  end
end