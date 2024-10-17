require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  let(:restaurant) { FactoryBot.create(:restaurant) }
  let(:menu) { FactoryBot.create(:menu, restaurant: restaurant) }

  it "is valid with valid attributes" do
    menu_item = MenuItem.new(name: "Fish1", price: 10.99, menu: menu)
    expect(menu_item).to be_valid
  end

  it "is not valid without a name" do
    menu_item = MenuItem.new(name: nil, price: 10.99, menu: menu)
    expect(menu_item).to_not be_valid
  end

  it "is not valid without a price" do
    menu_item = MenuItem.new(name: "Fish2", price: nil, menu: menu)
    expect(menu_item).to_not be_valid
  end

  it "is not valid with a negative price" do
    menu_item = MenuItem.new(name: "Fish3", price: -2.99, menu: menu)
    expect(menu_item).to_not be_valid
  end

  it "belongs to a menu" do
    menu_item = MenuItem.create(name: "Fish3", price: 15.99, menu: menu)
    expect(menu_item.menu).to eq(menu)
  end
end