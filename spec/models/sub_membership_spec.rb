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

require 'spec_helper'

describe SubMembership do
  describe "Associations" do
    it { should belong_to(:link)}
    it { should belong_to(:sub)}
  end
end
