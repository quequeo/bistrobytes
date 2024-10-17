class MenuItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price
  belongs_to :menu
end