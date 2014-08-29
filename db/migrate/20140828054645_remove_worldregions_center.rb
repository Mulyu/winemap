class RemoveWorldregionsCenter < ActiveRecord::Migration
  def change
    remove_column :worldregions , :center_x
    remove_column :worldregions , :center_y
  end
end
