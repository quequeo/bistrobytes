require 'rails_helper'

RSpec.describe Api::V1::MenusController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  let(:restaurant) { create(:restaurant) }

  describe "GET #index" do
    it "returns a success response" do
      create_list(:menu, 3, restaurant: restaurant)
      get :index, params: { restaurant_id: restaurant.id }
      expect(response).to be_successful
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET #show" do
    let(:menu) { create(:menu, restaurant: restaurant) }
    
    it "returns a success response" do
      get :show, params: { restaurant_id: restaurant.id, id: menu.id }
      expect(response).to be_successful
    end

    it "returns the menu with its menu items" do
      create_list(:menu_item, 2, menu: menu)
      get :show, params: { restaurant_id: restaurant.id, id: menu.id }
      expect(JSON.parse(response.body)['menu_items'].size).to eq(2)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Menu" do
        expect {
          post :create, params: { restaurant_id: restaurant.id, menu: attributes_for(:menu) }
        }.to change(Menu, :count).by(1)
      end

      it "renders a JSON response with the new menu" do
        post :create, params: { restaurant_id: restaurant.id, menu: attributes_for(:menu) }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        post :create, params: { restaurant_id: restaurant.id, menu: attributes_for(:menu, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end