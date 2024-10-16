require 'rails_helper'

RSpec.describe Menu, type: :model do
  it "is valid with valid attributes" do
    menu = Menu.new(name: "TEst Menu")
    expect(menu).to be_valid
  end

  it "is not valid without a name" do
    menu = Menu.new(name: nil)
    expect(menu).to_not be_valid
  end

  it "can have many menu items" do
    menu = Menu.create(name: "Test Menu")
    menu_item1 = MenuItem.create(name: "Fish1", price: 20.99, menu: menu)
    menu_item2 = MenuItem.create(name: "Fish2", price: 9.99, menu: menu)
    
    expect(menu.menu_items.count).to eq(2)
  end
end