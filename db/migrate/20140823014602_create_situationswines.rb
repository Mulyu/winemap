class CreateSituationswines < ActiveRecord::Migration
  def change
    create_table :situationswines ,id: false  do |t|
    		t.references :wine
    		t.references :situation
    		t.timestamps
    end
  end
end
