class Situationswine < ActiveRecord::Base
	belongs_to :wine 
	belongs_to :situation
end
