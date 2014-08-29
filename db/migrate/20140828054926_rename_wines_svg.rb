class RenameWinesSvg < ActiveRecord::Migration
  def change
    rename_column :wines , :svg_x , :svg_latitude
    rename_column :wines , :svg_y , :svg_longitude 
  end
end
