class CreateStockTables < ActiveRecord::Migration
  def change
    create_table :wines_winevarieties , id: false do |t|
      t.references :wine
      t.references :winevariety
    end

    create_table :situations_wines , id: false do |t|
      t.references :wine
      t.references :situation
    end
    
    create_table :users_users , id: false do |t|
      t.references :from_user
      t.references :to_user
    end
    
  end
end
