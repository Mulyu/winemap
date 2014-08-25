class User < ActiveRecord::Base
  belongs_to :prefecture
  has_many  :wines
  has_many  :usersusers
end
