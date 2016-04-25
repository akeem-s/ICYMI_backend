class PlaceCategories < ActiveRecord::Migration
  def change
  	create_table :place_categories do |t|
  		t.belongs_to :category, null: false, index: true
  		t.belongs_to :place, null: false, index: true
  		t.timestamps null: false
  	end
  end
end
