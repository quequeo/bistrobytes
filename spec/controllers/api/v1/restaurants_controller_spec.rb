require 'rails_helper'

RSpec.describe Api::V1::RestaurantsController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    it "returns a success response" do
      create_list(:restaurant, 3)
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      restaurant = create(:restaurant)
      get :show, params: { id: restaurant.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Restaurant" do
        expect {
          post :create, params: { restaurant: attributes_for(:restaurant) }
        }.to change(Restaurant, :count).by(1)
      end

      it "renders a JSON response with the new restaurant" do
        post :create, params: { restaurant: attributes_for(:restaurant) }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        post :create, params: { restaurant: attributes_for(:restaurant, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end