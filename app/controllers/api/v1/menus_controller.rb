class Api::V1::MenusController < ApplicationController
  before_action :set_restaurant, only: [:index, :create]
  before_action :set_menu, only: [:show, :update, :destroy]

  def index
    @menus = @restaurant.menus
    render json: @menus
  end

  def show
    render json: @menu, include: :menu_items
  end

  def create
    @menu = @restaurant.menus.build menu_params
    if @menu.save
      render json: @menu, status: :created
    else
      render json: @menu.errors, status: :unprocessable_entity
    end
  end

  def update
    if @menu.update menu_params
      render json: @menu
    else
      render json: @menu.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @menu.destroy
    head :no_content
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find params[:restaurant_id]
  end

  def set_menu
    @menu = Menu.find params[:id]
  end

  def menu_params
    params.require(:menu).permit(:name, :description)
  end
end