require 'rails_helper'

RSpec.describe "wines/index", :type => :view do
  before(:each) do
    assign(:wines, [
      Wine.create!(
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
      ),
      Wine.create!(
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
      )
    ])
  end

  it "renders a list of wines" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Photopath".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Winery".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
