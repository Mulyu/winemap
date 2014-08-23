class CreateSituations < ActiveRecord::Migration
  def change
    create_table :situations do |t|
      t.string :name , limit: 30

      t.timestamps
    end
  end
end
