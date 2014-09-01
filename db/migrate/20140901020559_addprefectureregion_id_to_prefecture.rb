class AddprefectureregionIdToPrefecture < ActiveRecord::Migration
  def change
    change_table :prefectures do |t|
      t.references :prefectureregions, null: false
    end
  end
end
