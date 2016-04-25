class PlaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :website, :created_at
  has_many :reviews
  has_many :photos
  has_many :categories
end
