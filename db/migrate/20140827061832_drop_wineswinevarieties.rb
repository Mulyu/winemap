class DropWineswinevarieties < ActiveRecord::Migration
  def change
    drop_table :wines_winevariaties
  end
end
