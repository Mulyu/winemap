class CreateCountrycodes < ActiveRecord::Migration
  def change
    create_table :countrycodes, id: false do |t|
      t.integer :code, null: false
      t.references :country, index: true, null: false
    end
  end
end
