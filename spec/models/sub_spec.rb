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

require 'spec_helper'

describe Sub do
  subject(:sub) { build(:sub) }

  describe "validations" do
    it { should validate_presence_of   :name }
    it { should validate_presence_of   :moderator_id }
    it do
      Sub.create!(name: 'Ruby', moderator_id: 1)
      should validate_uniqueness_of :name
    end
  end

  describe "associations" do
    it { should belong_to(:moderator).class_name('User') }
    it { should have_many(:sub_memberships) }
    it { should have_many(:links) }
  end

  describe "#is_moderator?" do
    let(:moderator) { User.create!(username: "Elmo", password: "foobar") }
    let(:normal_user) { User.create!(username: "Darma", password: "foobar") }
    before { sub.moderator = moderator }

    it "should return true for it's moderator" do
      expect(sub.is_moderator?(moderator)).to be_true
    end

    it "should return false for normal users" do
      expect(sub.is_moderator?(normal_user)).to be_false
    end
  end
end
