class Reviews < ActiveRecord::Migration
  def change
  	create_table :reviews do |t|
  		t.string :name
  		t.string :content
  		t.integer :rating
  		t.belongs_to :place, null: false, index: true
  	end
  end
end
