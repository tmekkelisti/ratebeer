class User < ActiveRecord::Base
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy

  has_secure_password

  include RatingAverage
  validates :username, uniqueness: true
  validates :username, length: {minimum: 3, maximum: 15}
  validates :password, length: {minimum: 4}
  validates :password, format: { with: /\d.*[A-Z]|[A-Z].*\d/,  message: "has to contain one number and one upper case letter" }

end
