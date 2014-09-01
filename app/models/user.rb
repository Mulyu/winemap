class User < ActiveRecord::Base
  belongs_to :prefecture , class_name: 'Prefecture' ,  foreign_key: 'prefecture_id'
  belongs_to :home_prefecture , class_name: 'Prefecture',  foreign_key: 'home_prefecture_id'

  has_many  :wines
  has_and_belongs_to_many  :users , dependent: :delete_all

  before_save { |user| user.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name,
    presence: true,
    length: { maximum: 15 }
  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX , allow_blank: true },
    uniqueness: { case_sensitive: false }
  validates :password,
    length: { minimum: 6 , maximum: 127 , allow_blank: true }
  validates :age,
    numericality: { only_integer: true, greater_than_or_equal_to: 20, less_than_or_equal_to: 120, allow_blank: true }
  validates :job,
    length: { maximum: 30 }
  validates :introduction,
    length: { maximum: 255 }

  has_secure_password
end