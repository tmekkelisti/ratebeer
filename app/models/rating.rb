class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user

  #def to_s
  #  return self.beer.name + " " + self.score.to_s
  #end

  def to_s
    "#{beer.name} #{score}"
  end


end
