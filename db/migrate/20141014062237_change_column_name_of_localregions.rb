class ChangeColumnNameOfLocalregions < ActiveRecord::Migration
  def change
    change_column :localregions, :name, :string, limit: 100, null: false
  end
end
