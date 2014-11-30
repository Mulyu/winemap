class Wine < ActiveRecord::Base
  belongs_to :country
  belongs_to :localregion
  belongs_to :user
  belongs_to :winetype
  has_and_belongs_to_many :situations , dependent: :delete_all
  has_and_belongs_to_many :winevarieties , dependent: :delete_all
  mount_uploader :photo , PhotoUploader

  validates :name,
    presence: { message: 'Nameを入力してください' },
    length: { maximum: 100, message: 'Nameは100文字以内で入力してください' }
  validates :input_region,
    presence: { message: 'Regionを入力して下さい' },
    length: { maximum: 100, message: 'Regionは100文字以内で入力してください' }
  validates :country_id,
    format: { with: /[^1]/, if: 'input_region.present?' , message: 'Regionが不明です' }
  validates :winetype_id,
    presence: { message: 'Typeを選択してください' }
  validates :winery,
    length: { maximum: 30 , message: 'Wineryは30文字以内で入力してください' }
  validates :year,
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: Date.today.year, allow_blank: true, message: 'Yearが不正な値です' }
  validates :price,
    numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 2147483647, allow_blank: true, message: 'Priceが不正な値です' }
  validates :score,
    inclusion: { in: 1..5, message: '好みが不正な値です' }
  validates :body,
    inclusion: { in: 1..5, message: '重さが不正な値です' }
  validates :sweetness,
    inclusion: { in: 1..5, message: '甘みが不正な値です' }
  validates :sourness,
    inclusion: { in: 1..5, message: '酸味が不正な値です' }

end
