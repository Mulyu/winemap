class RemoveTimestampsFromSituationsWines < ActiveRecord::Migration
  def change
    remove_timestamps :situationswines
  end
end
