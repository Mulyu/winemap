class RemoveTimestampsFromCountries < ActiveRecord::Migration
  def change
    remove_timestamps :countries
  end
end
