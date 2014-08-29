class AddInputRegionToWines < ActiveRecord::Migration
  def change
    add_column :wines, :input_region, :string, limit: 30, null: false
  end
end
