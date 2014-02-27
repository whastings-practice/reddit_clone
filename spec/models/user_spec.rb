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

require 'spec_helper'

describe User do
  subject(:user) { build(:user) }
  describe "Validations" do
    it "validates all required attributes" do
      should validate_presence_of(:username)
      should validate_presence_of(:password_digest)
    end
  end

  describe "Associations" do
    it { should have_many :moderated_subs }
    it { should have_many :links }
  end

  describe "#password=" do
    it 'should not set password_digest to the plain text password' do
      expect(user.password_digest).to_not eq('foobar')
    end

    it 'should show the password as nil' do
      user.save!
      expect(User.last.password).to be_nil
    end

    it 'should set a password hash that accepts our password' do
      password_hash = BCrypt::Password.new(user.password_digest)
      expect(password_hash).to eq('foobar')
    end
  end

  describe '#is_password?' do
    let(:password_hash) { BCrypt::Password.create('foobar').to_s }
    it "should be valid if a password is the same" do
      user.password_digest = password_hash
      expect(user.is_password?('foobar')).to be_true
    end
  end

  describe '#reset_session_token!' do
    let!(:current_session_token) { user.session_token }

    it "should change the session_token" do
      user.reset_session_token!
      expect(user.session_token).to_not eq(current_session_token)
    end

    it "should return the session token" do
      expect(user.reset_session_token!).to eq(user.session_token)
    end
  end

  describe '::generate_session_token' do
    it "should return a random string" do
      expect(User.generate_session_token.length).to eq(22)
    end
  end

  describe '::find_by_credentials' do
    let(:new_user) { create(:user, username: 'wilstep') }

    it "returns the user if the username and password are correct" do
      expect(User.find_by_credentials(new_user.username, 'foobar').username)
        .to eq(new_user.username)
    end

    it "returns nil if the username or the password are incorrect" do
      expect(User.find_by_credentials( new_user.username, 'not_foobar' ))
        .to be_nil
    end
  end
end
