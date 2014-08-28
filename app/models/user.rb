class User < ActiveRecord::Base
  belongs_to :prefecture
  has_many  :wines
  has_and_belongs_to_many  :users
end
