require 'rails_helper'

RSpec.describe Api::V1::MenuItemsController, type: :controller do
  let(:restaurant) { create(:restaurant) }
  let(:menu) { create(:menu, restaurant: restaurant) }

  describe "GET #index" do
    it "returns a success response" do
      create_list(:menu_item, 3, menu: menu)
      get :index, params: { restaurant_id: restaurant.id, menu_id: menu.id }
      expect(response).to be_successful
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      menu_item = create(:menu_item, menu: menu)
      get :show, params: { id: menu_item.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new MenuItem" do
        expect {
          post :create, params: { restaurant_id: restaurant.id, menu_id: menu.id, menu_item: attributes_for(:menu_item) }
        }.to change(MenuItem, :count).by(1)
      end

      it "renders a JSON response with the new menu_item" do
        post :create, params: { restaurant_id: restaurant.id, menu_id: menu.id, menu_item: attributes_for(:menu_item) }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        post :create, params: { restaurant_id: restaurant.id, menu_id: menu.id, menu_item: attributes_for(:menu_item, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    let(:menu_item) { create(:menu_item, menu: menu) }

    context "with valid params" do
      let(:new_attributes) { { name: "New Name" } }

      it "updates the requested menu_item" do
        put :update, params: { id: menu_item.to_param, menu_item: new_attributes }
        menu_item.reload
        expect(menu_item.name).to eq("New Name")
      end

      it "renders a JSON response with the menu_item" do
        put :update, params: { id: menu_item.to_param, menu_item: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors" do
        put :update, params: { id: menu_item.to_param, menu_item: attributes_for(:menu_item, name: nil) }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested menu_item" do
      menu_item = create(:menu_item, menu: menu)
      expect {
        delete :destroy, params: { id: menu_item.to_param }
      }.to change(MenuItem, :count).by(-1)
    end

    it "returns a no content response" do
      menu_item = create(:menu_item, menu: menu)
      delete :destroy, params: { id: menu_item.to_param }
      expect(response).to have_http_status(:no_content)
    end
  end
end