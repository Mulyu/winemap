class RemoveLocalregionIdFromWines < ActiveRecord::Migration
  def change
    remove_column :wines, :localregion_id
  end
end
