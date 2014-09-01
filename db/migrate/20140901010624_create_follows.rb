class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows , id: false do |t|
      
      t.references :from_user , null: false
      t.references :to_user , null: false

    end
  end
end
