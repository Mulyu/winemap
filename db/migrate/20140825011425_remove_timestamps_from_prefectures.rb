class RemoveTimestampsFromPrefectures < ActiveRecord::Migration
  def change
    remove_timestamps :prefectures
  end
end
