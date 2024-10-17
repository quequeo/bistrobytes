class Api::V1::ImportsController < ApplicationController
  def create
    data = JSON.parse(request.body.read)
    importer = RestaurantImporter.new(data)
    
    if importer.run
      render json: { message: 'Import successful', logs: importer.logs }, status: :ok
    else
      render json: { message: 'Import failed', errors: importer.errors }, status: :unprocessable_entity
    end
  rescue JSON::ParserError => e
    render json: { message: 'Invalid JSON format', error: e.message }, status: :bad_request
  end
end