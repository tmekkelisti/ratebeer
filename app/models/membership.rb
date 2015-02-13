class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer_club

  #def to_s
    #return self.beer_club.to_s
  #end



  def member
    return user.username
  end

  def name_of_beer_club
    return beer_club.name
  end

  def bc_id
    return beer_club.id
  end


end
