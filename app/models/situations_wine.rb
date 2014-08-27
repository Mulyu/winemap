class SituationsWine < ActiveRecord::Base
  belongs_to :wine_id
  belongs_to :situation_id
end
