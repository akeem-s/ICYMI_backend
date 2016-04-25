class User < ActiveRecord::Base
	has_many :places
	has_many :lat_longs

end
