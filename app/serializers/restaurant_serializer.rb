class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone
  has_many :menus
end