require 'rails_helper'

RSpec.describe RestaurantSerializer, type: :serializer do
  let(:restaurant) { create(:restaurant) }
  let!(:menus) { create_list(:menu, 2, restaurant: restaurant) }
  let(:serializer) { described_class.new(restaurant) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  subject { JSON.parse(serialization.to_json) }

  it 'has an id' do
    expect(subject['id']).to eq(restaurant.id)
  end

  it 'has a name' do
    expect(subject['name']).to eq(restaurant.name)
  end

  it 'has an address' do
    expect(subject['address']).to eq(restaurant.address)
  end

  it 'has a phone number' do
    expect(subject['phone']).to eq(restaurant.phone)
  end

  it 'has many menus' do
    expect(subject['menus'].length).to eq(2)
    expect(subject['menus'][0]['id']).to eq(menus[0].id)
    expect(subject['menus'][1]['id']).to eq(menus[1].id)
  end
end