class RatingsController < ApplicationController

  def index
    @top3_breweries = Brewery.top(3)
    @top3_beers = Beer.top(3)
    @top3_styles = Style.top(3)
    @top3_raters = User.top(3)
    @recent_ratings = Rating.recent
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

end