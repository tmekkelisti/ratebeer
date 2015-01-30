class User < ActiveRecord::Base
  has_many :ratings
  has_many :beers, through: :ratings
  has_many :memberships

  include RatingAverage
  validates :username, uniqueness: true
  validates :username, length: {minimum: 3, maximum: 15}

end
