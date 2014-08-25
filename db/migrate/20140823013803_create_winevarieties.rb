class CreateWinevarieties < ActiveRecord::Migration
  def change
    create_table :winevarieties do |t|
      t.string :name , limit: 30

      t.timestamps
    end
  end
end
