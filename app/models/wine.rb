class Wine < ActiveRecord::Base
	belongs_to :country 
	belongs_to :localregion 
	belongs_to :winetype 
	has_and_belongs_to_many :winevarieties 
	has_and_belongs_to_many :situations
  belongs_to :user
end

