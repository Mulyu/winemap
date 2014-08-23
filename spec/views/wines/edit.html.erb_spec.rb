require 'rails_helper'

RSpec.describe "wines/edit", :type => :view do
  before(:each) do
    @wine = assign(:wine, Wine.create!(
      :name => "MyString",
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
      :photopath => "MyString",
      :score => "",
      :price => "",
      :winery => "MyString",
      :user_id => "",
      :winelevel => 1.5
    ))
  end

  it "renders the edit wine form" do
    render

    assert_select "form[action=?][method=?]", wine_path(@wine), "post" do

      assert_select "input#wine_name[name=?]", "wine[name]"

      assert_select "input#wine_country_id[name=?]", "wine[country_id]"

      assert_select "input#wine_localregions_id[name=?]", "wine[localregions_id]"

      assert_select "input#wine_svg_x[name=?]", "wine[svg_x]"

      assert_select "input#wine_svg_y[name=?]", "wine[svg_y]"

      assert_select "input#wine_body[name=?]", "wine[body]"

      assert_select "input#wine_sweetness[name=?]", "wine[sweetness]"

      assert_select "input#wine_sourness[name=?]", "wine[sourness]"

      assert_select "input#wine_winetype_id[name=?]", "wine[winetype_id]"

      assert_select "input#wine_year[name=?]", "wine[year]"

      assert_select "input#wine_winevariety_id[name=?]", "wine[winevariety_id]"

      assert_select "input#wine_photopath[name=?]", "wine[photopath]"

      assert_select "input#wine_score[name=?]", "wine[score]"

      assert_select "input#wine_price[name=?]", "wine[price]"

      assert_select "input#wine_winery[name=?]", "wine[winery]"

      assert_select "input#wine_user_id[name=?]", "wine[user_id]"

      assert_select "input#wine_winelevel[name=?]", "wine[winelevel]"
    end
  end
end
