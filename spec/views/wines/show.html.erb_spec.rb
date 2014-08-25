require 'rails_helper'

RSpec.describe "wines/show", :type => :view do
  before(:each) do
    @wine = assign(:wine, Wine.create!(
      :name => "Name",
      :country_id => "",
      :localregions_id => "",
      :svg_x => "9.99",
      :svg_y => "9.99",
      :body => "",
      :sweetness => "",
      :sourness => "",
      :winetype_id => "",
      :year => "",
      :winevariety_id => "",
      :photopath => "Photopath",
      :score => "",
      :price => "",
      :winery => "Winery",
      :user_id => "",
      :winelevel => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Photopath/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Winery/)
    expect(rendered).to match(//)
    expect(rendered).to match(/1.5/)
  end
end
