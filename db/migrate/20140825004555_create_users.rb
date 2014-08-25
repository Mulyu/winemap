class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name  , limit:15 ,null: false
      t.string :email , null: false
      t.string :password  ,limit: 127, null:false
      t.integer :age
      t.integer :gender
      t.references :prefecture
      t.references :home_prefecture
      t.string :job , limit:30
      t.boolean :married
      t.string :introduction
      t.float :winelevel  , null: false
      t.integer :winenum  , null: false
      t.integer :follow   , null: false
      t.integer :follower , null: false
      t.integer :ranking  , null: false

      t.timestamps
    end
  end
end
