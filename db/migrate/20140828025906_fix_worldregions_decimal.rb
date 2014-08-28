class FixWorldregionsDecimal < ActiveRecord::Migration
  def change
    change_column  :worldregions , :center_x , :float , null: false
    change_column  :worldregions , :center_y , :float , null: false
  end
end
