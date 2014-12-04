class ChangeWineryFromWines < ActiveRecord::Migration
  def change
    change_column :wines, :winery, :string, limit: 100
  end
end
