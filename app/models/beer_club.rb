class BeerClub < ActiveRecord::Base
  has_many :users
  has_many :memberships

  def to_s
    return self.name
  end



end
