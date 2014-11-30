class User < ActiveRecord::Base
  belongs_to :prefecture , class_name: 'Prefecture' ,  foreign_key: 'prefecture_id'
  belongs_to :home_prefecture , class_name: 'Prefecture',  foreign_key: 'home_prefecture_id'
  belongs_to :logininfo

  # association Follow
  has_many :follows_to , class_name: 'Follow' , foreign_key: :from_user_id , dependent: :delete_all
  has_many :follows_from , class_name: 'Follow' , foreign_key: :to_user_id , dependent: :delete_all
  has_many :following , through: :follows_to , source: :to_user
  has_many :followed , through: :follows_from , source: :from_user

  has_many :wines

  def followed?(other_user)
    follows_to.find_by(to_user_id: other_user.id)
  end

  def following?(other_user)
    follows_from.find_by(from_user_id: other_user.id)
  end

  def follow!(other_user)
    follows_to.create!(to_user_id: other_user.id)
  end

  def remove!(other_user)
    follows_to.where(to_user_id: other_user.id).delete_all
  end

  validates :name,
    length: { maximum: 15, allow_blank: true, message: 'Nameは15文字以内で入力してください' }
  validates :birth,
    adult: true
  validates :job,
    length: { maximum: 30, message: 'Jobは30文字以内で入力してください'}
  validates :introduction,
    length: { maximum: 255, message: 'Introductionは255文字以内で入力してください' }

end