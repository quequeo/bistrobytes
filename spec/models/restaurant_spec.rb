require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let(:restaurant) { build(:restaurant) }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(restaurant).to be_valid
    end

    it "is not valid without a name" do
      restaurant.name = nil
      expect(restaurant).to_not be_valid
    end

    it "is valid without an address" do
      restaurant.address = nil
      expect(restaurant).to be_valid
    end

    it "is valid without a phone" do
      restaurant.phone = nil
      expect(restaurant).to be_valid
    end
  end

  describe "associations" do
    it "has many menus" do
      association = described_class.reflect_on_association(:menus)
      expect(association.macro).to eq :has_many
    end

    it "destroys associated menus when destroyed" do
      restaurant = create(:restaurant)
      create(:menu, restaurant: restaurant)
      expect { restaurant.destroy }.to change { Menu.count }.by(-1)
    end
  end
end