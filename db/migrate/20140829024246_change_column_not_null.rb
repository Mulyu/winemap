class ChangeColumnNotNull < ActiveRecord::Migration
  def change
    change_table :wines do |t|
      t.remove :country_id, :winetype_id, :user_id
      t.references :country, null: false
      t.references :winetype, null: false
      t.references :user, null: false
      t.change :winelevel, :float, null: false
    end

    change_column  :worldregions, :name, :string, limit: 10, null: false

    change_table :countries do |t|
      t.remove :worldregion_id
      t.references :worldregion, null: false
      t.change :name, :string, limit: 30, null: false
      t.change :ranking, :integer, null: false
      t.change :svg_id, :string, limit: 5, null: false
      t.change :center_x, :decimal, precision: 8, scale: 5, null: false
      t.change :center_y, :decimal, precision: 8, scale: 5, null: false
    end

    change_column  :winevarieties, :name, :string, limit: 30, null: false

    change_table :wines_winevarieties do |t|
      t.remove :wine_id
      t.references :wine, null: false
      t.remove :winevariety_id
      t.references :winevariety, null: false
    end

    change_table :situations_wines do |t|
      t.remove :wine_id
      t.references :wine, null: false
      t.remove :situation_id
      t.references :situation, null: false
    end

    change_column  :situations, :name, :string, limit: 30, null: false

    change_table :users_users do |t|
      t.remove :from_user_id
      t.references :from_user, null: false
      t.remove :to_user_id
      t.references :to_user, null: false
    end

    change_table :users do |t|
      t.remove :prefecture_id
      t.references :prefecture, null: false
      t.remove :home_prefecture_id
      t.references :home_prefecture, null: false
    end
  end
end
