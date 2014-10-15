class AddLocalregionIdToWines < ActiveRecord::Migration
  def change
    add_column :wines, :localregion_id, :integer, null: false
    add_index :wines, :localregion_id
  end
end
