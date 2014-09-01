class Prefecture < ActiveRecord::Base
  belongs_to :prefectureregions ,foreign_key: 'prefectureregion_id'
  has_many  :users
end
