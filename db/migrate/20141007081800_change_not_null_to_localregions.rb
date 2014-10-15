class ChangeNotNullToLocalregions < ActiveRecord::Migration
  def change
    change_table :localregions do |t|
      t.change :name, :string, limit: 30, null: false
      t.change :ranking, :integer, null: false
      t.remove :country_id
      t.references :country, null: false
    end
  end
end
