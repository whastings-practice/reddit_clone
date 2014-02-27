require 'spec_helper'

describe User do
  describe "Validations" do
    it "validates all required attributes" do
      should validate_presence_of(:username)
      should validate_presence_of(:password_digest)
      should validate_presence_of(:session_token)
    end
  end
end