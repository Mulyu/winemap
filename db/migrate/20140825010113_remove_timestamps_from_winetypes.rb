class RemoveTimestampsFromWinetypes < ActiveRecord::Migration
  def change
    remove_timestamps :winetypes
  end
end
