class CreateUsersusers < ActiveRecord::Migration
  def change
    create_table :usersusers,id: false do |t|
      t.references :from_user
      t.references :to_user
      t.timestamps
    end
  end
end
