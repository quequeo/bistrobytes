require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "is not valid without an email" do
      user = build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it "is not valid with a duplicate email" do
      create(:user, email: "test@example.com")
      user = build(:user, email: "test@example.com")
      expect(user).to_not be_valid
    end

    it "is not valid without a password" do
      user = build(:user, password: nil)
      expect(user).to_not be_valid
    end
  end

  describe "Devise modules" do
    it "uses database_authenticatable" do
      expect(User.devise_modules).to include(:database_authenticatable)
    end

    it "uses registerable" do
      expect(User.devise_modules).to include(:registerable)
    end

    it "uses recoverable" do
      expect(User.devise_modules).to include(:recoverable)
    end

    it "uses rememberable" do
      expect(User.devise_modules).to include(:rememberable)
    end

    it "uses validatable" do
      expect(User.devise_modules).to include(:validatable)
    end

    it "uses jwt_authenticatable" do
      expect(User.devise_modules).to include(:jwt_authenticatable)
    end
  end

  describe "JWT configuration" do
    it "uses JwtDenylist as revocation strategy" do
      expect(User.jwt_revocation_strategy).to eq(JwtDenylist)
    end
  end
end