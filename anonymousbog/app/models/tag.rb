class Tag < ActiveRecord::Base
  has_many :posts, through: :relations
  has_many :relations
end