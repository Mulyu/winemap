class AddLogininfoMobiletoken < ActiveRecord::Migration
  def change
  	add_column :logininfos, :mobile_token, :string, :limit => 16
  end
end
