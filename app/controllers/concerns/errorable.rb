module Errorable
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound,         with: :handle_record_not_found
    rescue_from ActionController::ParameterMissing,   with: :bad_request
    rescue_from ActiveRecord::RecordNotUnique,        with: :unprocessable_entity
  end

  private

  def handle_record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def unprocessable_entity(exception)
    render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def bad_request(exception)
    render json: { error: exception.message }, status: :bad_request
  end
end