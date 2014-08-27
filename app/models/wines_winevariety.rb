class WinesWinevariety < ActiveRecord::Base
  belongs_to :wine_id
  belongs_to :winevariety_id
end
