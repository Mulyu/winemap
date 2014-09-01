class User < ActiveRecord::Base
  belongs_to :prefecture , class_name: 'Prefecture' ,  foreign_key: 'prefecture_id'
  belongs_to :home_prefecture , class_name: 'Prefecture',  foreign_key: 'home_prefecture_id'

  #has_and_belongs_to_many :follow_users , class_name: 'User' ,foreign_key: 'from_user_id' , dependent: :delete_all
  #has_and_belongs_to_many  :follow_users ,class_name: 'User',foreign_key: 'from_user_id',association_foreign_key: 'to_user_id' ,dependent: :delete_all
  #has_and_belongs_to_many  :follower_users ,class_name: 'User',forein_lyu: 'to_user_id' ,association_foreign_key: 'from_user_id' ,dependent: :delete_all
  
  # association Follow
  has_many :follows_from , class_name: 'Follow' , foreign_key: :from_user_id , dependent: :delete_all
  has_many :follows_to , class_name: 'Follow' , foreign_key: :to_user_id , dependent: :delete_all
  has_many :following , through: :follows_from , source: :to_user
  has_many :followed , through: :follows_to , source: :from_user


  has_many  :wines
  
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
  validates :age,
    numericality: { only_integer: true, greater_than_or_equal_to: 20, less_than_or_equal_to: 120, allow_blank: true }
  validates :job,
    length: { maximum: 30 }
  validates :introduction,
    length: { maximum: 255 }

  has_secure_password

end