class CreateLocalregions < ActiveRecord::Migration
  def change
    create_table :localregions do |t|
      t.string :name , limit: 30
      t.integer :ranking
      t.references :country

      t.timestamps
    end
  end
end
