class Wine < ActiveRecord::Base
	belongs_to :country 
	belongs_to :localregion 
	belongs_to :winetype 
	belongs_to :winevariety 
	has_many :situationswine
end

