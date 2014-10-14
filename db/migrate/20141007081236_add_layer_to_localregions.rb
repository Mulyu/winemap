class AddLayerToLocalregions < ActiveRecord::Migration
  def change
    add_column :localregions, :layer, :integer, null: false
  end
end
