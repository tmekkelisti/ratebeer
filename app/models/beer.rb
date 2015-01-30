class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user
  include RatingAverage

  validates :name, presence: true

  #def average_rating
  #  return self.ratings.average(:score).to_s
  #end

  def to_s
    return self.name + " " + self.brewery.name
  end

end
