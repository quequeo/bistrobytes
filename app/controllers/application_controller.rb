class ApplicationController < ActionController::API
  include Errorable

  before_action :authenticate_user!

  private

  def authenticate_user!
    if user_signed_in?
      super
    else
      render json: { error: 'You must be logged in to access this resource.' }, status: :unauthorized
    end
  end
end
