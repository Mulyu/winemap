class Wine < ActiveRecord::Base
	belongs_to :country
	belongs_to :localregion
	belongs_to :winetype
	belongs_to :winevariety
	belongs_to :user
  has_many :situationswines

  validates :name,
    presence: true,
    length: { minimum: 1, maximum: 100 }
  validates :body, :sweetness, :sourness,
    inclusion: { in: 0..5 }
  validates :winetype_id,
    presence: true
  validates :year,
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: Time.now.year }
  validates :winevariety_id,
    presence: true
  validates :score,
    inclusion: { in: 1..5 }
  validates :price,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :winery,
    length: { maximum: 30 }

end

