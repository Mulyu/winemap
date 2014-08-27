class CreateWineswinevariaties < ActiveRecord::Migration
  def change
    create_table :wines_winevariaties,id: false do |t|
      t.references :wine
      t.references :winevariety
    end
  end
end
