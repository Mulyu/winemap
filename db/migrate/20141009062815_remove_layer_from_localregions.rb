class RemoveLayerFromLocalregions < ActiveRecord::Migration
  def change
    remove_column :localregions, :layer
  end
end
