class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :website, :created_at, :favorite, :phone
  has_many :categories
end
