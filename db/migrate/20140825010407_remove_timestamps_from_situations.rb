class RemoveTimestampsFromSituations < ActiveRecord::Migration
  def change
    remove_timestamps :situations
  end
end
