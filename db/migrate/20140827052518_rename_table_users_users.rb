class RenameTableUsersUsers < ActiveRecord::Migration
  def change
    rename_table :usersusers,:users_users
  end
end
