class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, dependent: :destroy
  include RatingAverage

  #def average_rating
  #  return self.ratings.average(:score).to_s
  #end

  def to_s
    return self.name + " " + self.brewery.name
  end

end
