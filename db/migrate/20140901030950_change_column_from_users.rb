class ChangeColumnFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :prefecture_id, :home_prefecture_id
      t.references :prefecture
      t.references :home_prefecture
    end
  end
end
