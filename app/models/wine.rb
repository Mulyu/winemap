class Wine < ActiveRecord::Base
	belongs_to :country
	belongs_to :localregion
	belongs_to :winetype
  belongs_to :user
  has_and_belongs_to_many :winevarieties , dependent: :delete_all
  has_and_belongs_to_many :situations , dependent: :delete_all

  attr_accessor :country_or_region

  validates :name, :country_or_region,
    presence: true,
    length: { maximum: 100 }
  validates :body, :sweetness, :sourness,
    inclusion: { in: 0..5 }
  validates :winetype_id,
    presence: true
  validates :year,
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: Time.now.year, allow_blank: true }
  validates :score,
    inclusion: { in: 1..5 }
  validates :price,
    numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_blank: true }
  validates :winery,
    length: { maximum: 30 }

end
