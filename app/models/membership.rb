class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer_club

  def to_s
    return self.beer_club.name
  end

  def member
    return user.username
  end


end
