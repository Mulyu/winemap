class CreateWineswinevarieties < ActiveRecord::Migration
  def change
    create_table :wineswinevarieties,id: false do |t|
      t.references :wine
      t.references :winevariety

      t.timestamps
    end
  end
end
