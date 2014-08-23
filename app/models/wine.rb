class Wine < ActiveRecord::Base
	belongs_to :country , :localregion ,:winetype , :winevariety 
	has_many :situationswine
end

