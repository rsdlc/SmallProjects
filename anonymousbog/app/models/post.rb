class Post < ActiveRecord::Base
  validates :body, :presence => true
  validates :title, :presence => true
  has_many :tags, through: :relations
  has_many :relations
end

