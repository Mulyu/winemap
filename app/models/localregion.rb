class Localregion < ActiveRecord::Base
	belongs_to :country
	has_many :wines
end
