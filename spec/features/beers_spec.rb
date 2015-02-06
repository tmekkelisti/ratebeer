require 'rails_helper'

describe 'Beer' do

  before :each do
    FactoryGirl.create :user
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "can be created with valid name" do

    visit new_beer_path
    fill_in('beer_name', with:'KARAJALA')


    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
    expect(current_path).to eq(beers_path)
  end

  it "can not be created without a name" do
    visit new_beer_path
    #click_button('Create Beer')

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "New Beer"
    expect(current_path).to eq(beers_path)

  end

end