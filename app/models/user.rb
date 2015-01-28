class User < ActiveRecord::Base
  has_many :ratings
  include RatingAverage
  validates :username, uniqueness: true
  validates :username, length: {minimum: 3}

end
