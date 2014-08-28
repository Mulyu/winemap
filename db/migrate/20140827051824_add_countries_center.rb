class AddCountriesCenter < ActiveRecord::Migration
  def change
    add_column  :countries , :center_x , :decimal , precision: 8 , scale: 5
    add_column  :countries , :center_y , :decimal , precision: 8 , scale: 5 
  end
end
