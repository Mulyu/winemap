class DeleteWineNum < ActiveRecord::Migration
  def change
  	remove_column :users, :winenum
  end
end
