class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]

  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @clubs = BeerClub.all
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships
  # POST /memberships.json
  def create
    @membership = Membership.new(membership_params)

    @membership = Membership.new params.require(:membership).permit(:beer_club_id)
    @membership.user_id = current_user.id


    if @membership.save
      @membership.beer_club_id = :beer_club_id
      redirect_to beer_clubs_path(@beer_club), notice: "#{current_user.username}, your application to the club is applied!"
    else
      @membership = Membership.new
      @clubs = BeerClub.all
      render :new
    end



    #respond_to do |format|
      #if @membership.save
       # format.html { redirect_to @membership, notice: 'Membership was successfully created.' }
      #  format.json { render :show, status: :created, location: @membership }
     # else
       # format.html { render :new }
      #  format.json { render json: @membership.errors, status: :unprocessable_entity }
     # end
    #end
  end

  # PATCH/PUT /memberships/1
  # PATCH/PUT /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy

    name = @membership.name_of_beer_club
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: "Membership in #{name} ended" }
      format.json { head :no_content }
    end
  end

  def confirm_member
    membership = Membership.find(params[:id])
    membership.update_attribute(:confirmed, true)

    redirect_to :back, notice:"#{membership.member} confirmed to the club!"

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
      params.require(:membership).permit(:beer_club_id, :user_id)
    end
end
