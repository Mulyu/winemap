class User < ActiveRecord::Base
  belongs_to :prefecture , class_name: 'Prefecture' ,  foreign_key: 'prefecture_id'
  belongs_to :home_prefecture , class_name: 'Prefecture',  foreign_key: 'home_prefecture_id'
  belongs_to :logininfo
  
  # association Follow
  has_many :follows_from , class_name: 'Follow' , foreign_key: :from_user_id , dependent: :delete_all
  has_many :follows_to , class_name: 'Follow' , foreign_key: :to_user_id , dependent: :delete_all
  has_many :following , through: :follows_from , source: :to_user
  has_many :followed , through: :follows_to , source: :from_user
  
  has_many :wines
  
  validates :name,
    presence: true,
    length: { maximum: 15 }
  validates :birth,
    adult: true
  validates :job,
    length: { maximum: 30 }
  validates :introduction,
    length: { maximum: 255 }

end