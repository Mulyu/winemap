class RemoveTimestampsFromWinevarieties < ActiveRecord::Migration
  def change
    remove_timestamps :winevarieties
  end
end
