class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user

  scope :recent, -> {order(:created_at).reverse_order.limit(5)}

  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }
  #def to_s
  #  return self.beer.name + " " + self.score.to_s
  #end

  def to_s
    "#{beer.name} #{score}"
  end


end
