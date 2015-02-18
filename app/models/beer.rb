class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user
  belongs_to :style
  include RatingAverage

  validates :name, presence: true
  validates :style, presence: true

  #def average_rating
  #  return self.ratings.average(:score).to_s
  #end

  def to_s
    return self.name + " " + self.brewery.name
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }
    return sorted_by_rating_in_desc_order.take(n)
  end

end
