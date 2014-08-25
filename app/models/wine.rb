class Wine < ActiveRecord::Base
	belongs_to :country 
	belongs_to :localregion 
	belongs_to :winetype 
	belongs_to :winevariety 
	belongs_to :user
  has_many :situationswines

end

