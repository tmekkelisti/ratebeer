require 'rails_helper'

describe Beer do
  it "is saved with name and style" do
    #beer = Beer.create name:"Iso3", style:"Lager"
    beer = FactoryGirl.create(:beer)
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    tyyli = FactoryGirl.create(:style)
    beer = Beer.create style: tyyli
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"Lager"
    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

end
