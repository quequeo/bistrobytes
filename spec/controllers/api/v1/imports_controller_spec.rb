require 'rails_helper'

RSpec.describe Api::V1::ImportsController, type: :controller do
  describe "POST #create" do
    let(:valid_json) do
      [{
        name: "Test Restaurant",
        address: "123 Street",
        phone: "7777777777",
        menus: [{
          name: "Menu 1",
          description: "Menu 1 description",
          items: [{
            name: "Menu Item 1",
            description: "Delicious food",
            price: 10
          }]
        }]
      }].to_json
    end

    let(:invalid_json) { "{ invalid: json }" }

    context "with valid JSON data" do
      it "imports the data successfully" do
        request.env['CONTENT_TYPE'] = 'application/json'
        post :create, body: valid_json
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Import successful')
        expect(json_response['logs']).to be_an(Array)
        expect(json_response['logs'].size).to eq(3) # Restaurant, Menu, and MenuItem logs
      end

      it "creates the correct number of records" do
        expect {
          request.env['CONTENT_TYPE'] = 'application/json'
          post :create, body: valid_json
        }.to change(Restaurant, :count).by(1)
          .and change(Menu, :count).by(1)
          .and change(MenuItem, :count).by(1)
      end
    end

    context "with invalid JSON data" do
      it "returns an error message" do
        request.env['CONTENT_TYPE'] = 'application/json'
        post :create, body: invalid_json
        expect(response).to have_http_status(:bad_request)
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq('Invalid JSON format')
      end
    end
  end
end