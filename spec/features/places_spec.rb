require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
                                 [ Place.new( name:"Oljenkorsi", id: 1 ) ]
                             )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple results are returned by the API, all of them is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("haaga").and_return(
                                 [Place.new( name:"nuta", id: 1),
                                 Place.new( name:"vako", id: 2)]
                             )
    visit places_path
    fill_in('city', with: 'haaga')
    click_button "Search"

    expect(page).to have_content "nuta"
    expect(page).to have_content "vako"
  end

  it "if there are no places at given location, show notice" do
    allow(BeermappingApi).to receive(:places_in).with("kallio").and_return([])
    visit places_path
    fill_in('city', with: 'kallio')
    click_button "Search"

    expect(page).to have_content "No places in kallio"
  end

end