class RemoveTimestampsFromWorldregions < ActiveRecord::Migration
  def change
    remove_timestamps :worldregions
  end
end
