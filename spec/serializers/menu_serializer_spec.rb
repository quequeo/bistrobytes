require 'rails_helper'

RSpec.describe MenuSerializer, type: :serializer do
  let(:restaurant) { create(:restaurant) }
  let(:menu) { create(:menu, restaurant: restaurant) }
  let!(:menu_items) { create_list(:menu_item, 2, menu: menu) }
  let(:serializer) { described_class.new(menu) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  subject { JSON.parse(serialization.to_json) }

  it 'has an id' do
    expect(subject['id']).to eq(menu.id)
  end

  it 'has a name' do
    expect(subject['name']).to eq(menu.name)
  end

  it 'has a description' do
    expect(subject['description']).to eq(menu.description)
  end

  it 'has many menu items' do
    expect(subject['menu_items'].length).to eq(2)
    expect(subject['menu_items'][0]['id']).to eq(menu_items[0].id)
    expect(subject['menu_items'][1]['id']).to eq(menu_items[1].id)
  end

  it 'belongs to a restaurant' do
    expect(subject['restaurant']['id']).to eq(restaurant.id)
  end
end