class CreateLocalregionsWines < ActiveRecord::Migration
  def change
    create_table :localregions_wines, id: false do |t|
      t.references :localregion, null: false
      t.references :wine, null: false
    end
  end
end
