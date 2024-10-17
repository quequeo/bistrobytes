require 'rails_helper'

RSpec.describe MenuItemSerializer, type: :serializer do
  let(:menu) { create(:menu) }
  let(:menu_item) { create(:menu_item, menu: menu) }
  let(:serializer) { described_class.new(menu_item) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  subject { JSON.parse(serialization.to_json) }

  it 'has an id' do
    expect(subject['id']).to eq(menu_item.id)
  end

  it 'has a name' do
    expect(subject['name']).to eq(menu_item.name)
  end

  it 'has a description' do
    expect(subject['description']).to eq(menu_item.description)
  end

  it 'has a price' do
    expect(subject['price']).to eq(menu_item.price.to_s)
  end

  it 'belongs to a menu' do
    expect(subject['menu']['id']).to eq(menu.id)
  end
end