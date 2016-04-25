class Place < ActiveRecord::Base
	has_many :reviews
	has_many :photos
	has_many :place_categories
	has_many :categories, through: :place_categories
	has_one :hour


end
