class FixPhotopathPhoto < ActiveRecord::Migration
  def change
  	remove_column :wines, :photopath
  	add_column :wines ,:photo, :string
  end
end
