class RenamePrefectureregionsIdToPrefectureregionId < ActiveRecord::Migration
  def change
    change_table :prefectures do |t|
      t.remove :prefectureregions_id
      t.references :prefectureregion, null: false
    end
  end
end
