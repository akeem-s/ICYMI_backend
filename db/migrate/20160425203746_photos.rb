class Photos < ActiveRecord::Migration
  def change
  	create_table :photos do |t|
  		t.string :url, index: true, null: false
  		t.belongs_to :place
  	end
  end
end
