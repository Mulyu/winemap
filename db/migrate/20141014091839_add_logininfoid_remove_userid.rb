class AddLogininfoidRemoveUserid < ActiveRecord::Migration
  def change
    remove_column :logininfos,:user_id
    add_column :users, :logininfo_id, :int, null: false

  end
end
