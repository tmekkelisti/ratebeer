require 'rails_helper'


describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "shows all ratings and amount of ratings" do
    FactoryGirl.create(:rating, score:10, beer:beer1, user:user)
    FactoryGirl.create(:rating, score:10, beer:beer2, user:user)
    FactoryGirl.create(:rating, score:50, beer:beer1, user:user)

    visit ratings_path
    expect(page).to have_content "Number of ratings: 3"
    expect(Rating.count).to eq(3)
  end

  it "shows users all ratings in user page" do
    FactoryGirl.create(:rating, score:10, beer:beer1, user:user)
    FactoryGirl.create(:rating, score:10, beer:beer2, user:user)
    FactoryGirl.create(:rating, score:50, beer:beer1, user:user)
    user2 = FactoryGirl.create(:user, username:'Pek')
    FactoryGirl.create(:rating, score:50, beer:beer1, user:user2)

    visit user_path(user)
    expect(page).to have_content "Has 3 ratings"
    visit user_path(user2)
    expect(page).to have_content "Has 1 rating"
    expect(Rating.count).to eq(4)
  end

  it "deletes a rating also from DB" do
    FactoryGirl.create(:rating, score:10, beer:beer1, user:user)
    FactoryGirl.create(:rating, score:10, beer:beer2, user:user)
    FactoryGirl.create(:rating, score:50, beer:beer1, user:user)

    visit user_path(user)
    within('ul') do
      click_link( "delete", :match => :first )
    end

    expect(page).to have_content "Has 2 ratings"
    expect(Rating.count).to eq(2)
  end

end
