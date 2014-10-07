class AddUseridLogininfo < ActiveRecord::Migration
  def change
    add_column :logininfos, :user_id, :int, null: false
  end
end
