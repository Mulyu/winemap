class CreateWinetypes < ActiveRecord::Migration
  def change
    create_table :winetypes do |t|
    		t. string :name , limit: 10 
      	t.timestamps
    end
  end
end
