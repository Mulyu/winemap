class ChangeLocalregionNonnull < ActiveRecord::Migration
  def change
    change_column  :wines , :localregion_id , :integer , null: false 
  end
end
