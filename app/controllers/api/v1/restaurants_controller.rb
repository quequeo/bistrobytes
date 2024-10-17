class Api::V1::RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :update, :destroy]

  def index
    @restaurants = Restaurant.page(params[:page]).per(10)
    render json: @restaurants, meta: pagination_meta(@restaurants)
  end

  def show
    render json: @restaurant, include: { menus: { include: :menu_items } }
  end

  def create
    @restaurant = Restaurant.new restaurant_params
    if @restaurant.save
      render json: @restaurant, status: :created
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  def update
    if @restaurant.update restaurant_params
      render json: @restaurant
    else
      render json: @restaurant.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant.destroy
    head :no_content
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find params[:id]
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone)
  end

  def pagination_meta(object)
    {
      current_page: object.current_page,
      next_page: object.next_page,
      prev_page: object.prev_page,
      total_pages: object.total_pages,
      total_count: object.total_count
    }
  end
end