module Errorable
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  end

  private

  def handle_record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end