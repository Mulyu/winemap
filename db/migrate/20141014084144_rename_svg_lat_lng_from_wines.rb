class RenameSvgLatLngFromWines < ActiveRecord::Migration
  def change
    rename_column :wines, :svg_latitude, :latitude
    rename_column :wines, :svg_longitude, :longitude
  end
end
