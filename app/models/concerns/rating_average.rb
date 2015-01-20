module RatingAverage
  extend ActiveSupport::Concern

  def average_rating
    return self.ratings.average(:score).to_s
  end
end