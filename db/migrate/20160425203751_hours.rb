class Hours < ActiveRecord::Migration
  def change
  	create_table :hours do |t|
  		t.string :mon, null: false
  		t.string :tues, null: false
  		t.string :wed, null: false
  		t.string :thurs, null: false
  		t.string :fri, null: false
  		t.string :sat, null: false
  		t.string :sun, null: false
  		t.belongs_to :place, index: true, null: false
  	end
  end
end
