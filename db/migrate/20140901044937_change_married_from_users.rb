class ChangeMarriedFromUsers < ActiveRecord::Migration
  def change
    change_column :users, :married, :integer, default: 0
  end
end
