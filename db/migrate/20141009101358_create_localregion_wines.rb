class CreateLocalregionWines < ActiveRecord::Migration
  def change
    create_table :localregion_wines, id: false do |t|
      t.references :localregion, index: true, null: false
      t.references :wine, index: true, null: false
      t.integer :layer, null: false
    end
  end
end
