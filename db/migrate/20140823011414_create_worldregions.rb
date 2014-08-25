class CreateWorldregions < ActiveRecord::Migration
  def change
    create_table :worldregions do |t|
    		t.string		:name , limit:10
    		t.decimal 	:center_x , precision: 8 , scale: 5
    		t.decimal	:center_y , precision: 8 , scale: 5 
      	t.timestamps
    end
  end
end
