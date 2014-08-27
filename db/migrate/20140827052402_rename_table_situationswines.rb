class RenameTableSituationswines < ActiveRecord::Migration
  def change
    rename_table :situationswines,:situations_wines
  end
end
