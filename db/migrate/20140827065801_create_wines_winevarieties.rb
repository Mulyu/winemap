class CreateWinesWinevarieties < ActiveRecord::Migration
  def change
    create_table :wines_winevarieties , id: false do |t|
      t.references :wine_id, index: true
      t.references :winevariety_id, index: true

    end
  end
end
