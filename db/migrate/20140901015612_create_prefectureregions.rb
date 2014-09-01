class CreatePrefectureregions < ActiveRecord::Migration
  def change
    create_table :prefectureregions do |t|
      t.string :name , limit: 6  , null: false
    end
  end
end
