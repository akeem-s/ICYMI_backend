class Users < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :first_name, null: false
  		t.string :last_name, null: false
  		t.string :username, null: false, index: true, unique: true
  		t.string :email, null: false
  		t.timestamps null: false
  	end
  end
end
