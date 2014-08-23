class Country < ActiveRecord::Base
	belongs_to :worldregion
	has_many :localregion , :wine
end
