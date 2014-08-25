class Country < ActiveRecord::Base
	belongs_to :worldregion ,foreign_key: 'worldregion_id'
	has_many :localregions 
	has_many :wines
end
