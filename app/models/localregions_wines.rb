class LocalregionsWines < ActiveRecord::Base
  belongs_to :localregion
  belongs_to :wine
end
