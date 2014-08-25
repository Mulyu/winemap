class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
      t.string :name , limit: 100 ,null: false 
      t.references :country
      t.references :localregion
      t.decimal :svg_x , precision: 8, scale: 5 , null: false
      t.decimal :svg_y , precision: 8, scale: 5 , null: false
      t.integer :body 
      t.integer :sweetness
      t.integer :sourness
      t.references :winetype
      t.integer :year
      t.references :winevariety
      t.string :photopath , limit: 30 
      t.integer :score
      t.integer :price
      t.string :winery, limit: 30
      t.references :user
      t.float :winelevel

      t.timestamps
    end
  end
end
