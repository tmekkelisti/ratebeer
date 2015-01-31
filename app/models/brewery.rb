class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers
  include RatingAverage

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

  #def average_rating
  #  return self.ratings.average(:score).to_s
  #end


end
