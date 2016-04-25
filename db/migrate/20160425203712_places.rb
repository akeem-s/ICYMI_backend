class Places < ActiveRecord::Migration
  def change
  	create_table :places do |t|
  		t.string :name, null: false, index: true, unique: true
  		t.string :address, null: false
  		t.string :phone
  		t.string :website
  		t.boolean :favorite, null: false, index: true
  		t.belongs_to :user, null: false, index: true
  		t.timestamps null: false
  	end
  end
end
