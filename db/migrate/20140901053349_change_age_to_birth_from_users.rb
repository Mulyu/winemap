class ChangeAgeToBirthFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :age
    add_column :users, :birth, :date
  end
end
