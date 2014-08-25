class CreatePrefectures < ActiveRecord::Migration
  def change
    create_table :prefectures do |t|

      t.string  :name , limit: 5  , null: false

      t.timestamps
    end
  end
end
