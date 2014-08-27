class RemoveWinevarietyIdFromWines < ActiveRecord::Migration
  def change
    remove_column :wines , :winevariety_id
    
  end
end
