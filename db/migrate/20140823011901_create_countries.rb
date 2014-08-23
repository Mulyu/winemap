class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name , limit: 30
      t.integer :ranking 
      t.string :svg_id , limit: 5
      t.references :worldregion

      t.timestamps
    end
  end
end
