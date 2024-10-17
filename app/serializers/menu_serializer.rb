class MenuSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :menu_items
  belongs_to :restaurant
end