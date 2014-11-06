class ChangeMarriedFromUsers < ActiveRecord::Migration
  def change
    adapter = ActiveRecord::Base.connection.instance_values['config'][:adapter]
    if adapter == 'postgresql'
      change_column :users, :married, 'integer USING CAST(married AS integer)', default: 0
    else
      change_column :users, :married, :integer, default: 0
    end
  end
end
