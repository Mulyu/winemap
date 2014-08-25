class RemoveTimestampsFromLocalregions < ActiveRecord::Migration
  def change
    remove_timestamps :localregions
  end
end
