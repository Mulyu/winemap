class LocalregionWine < ActiveRecord::Base
  belongs_to :localregion
  belongs_to :wine
end
