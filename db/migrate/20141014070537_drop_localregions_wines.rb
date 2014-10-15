class DropLocalregionsWines < ActiveRecord::Migration
  def change
    drop_table :localregions_wines
  end
end
