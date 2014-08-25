class Country < ActiveRecord::Base
	belongs_to :worldregion ,foreign_key: 'worldregion_id'
	has_many :localregion 
	has_many :wine
end
