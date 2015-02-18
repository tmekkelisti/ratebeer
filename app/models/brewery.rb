class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  include RatingAverage

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false]}

  validates :name, presence: true
  validates :year, numericality: { greater_than_or_equal_to: 1042,
                                  #less_than_or_equal_to: 2015,
                                  only_integer: true}
  validate :year_cannot_be_in_the_future

  def year_cannot_be_in_the_future
    if year > Date.today.year
      errors.add(:year, "can't be in the future")
    end
  end

  def to_s
    return self.name
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }
    return sorted_by_rating_in_desc_order.take(n)
  end


end
