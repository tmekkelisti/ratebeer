class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    ratingit = self.ratings
    scoret = 0
    scoret << ratingit.each do |beer|
      puts beer.score
    end
  end

end
