require 'rails_helper'

RSpec.describe "users/index", :type => :view do
  before(:each) do
    assign(:users, [
      User.create!(
        :name => "Name",
        :email => "Email",
        :password => "Password",
        :age => 1,
        :gender => 2,
        :prefecture => "",
        :home_prefecture => nil,
        :job => "Job",
        :married => "",
        :introduction => "Introduction",
        :winelevel => 1.5,
        :winenum => 3,
        :follow => 4,
        :follower => 5,
        :ranking => 6
      ),
      User.create!(
        :name => "Name",
        :email => "Email",
        :password => "Password",
        :age => 1,
        :gender => 2,
        :prefecture => "",
        :home_prefecture => nil,
        :job => "Job",
        :married => "",
        :introduction => "Introduction",
        :winelevel => 1.5,
        :winenum => 3,
        :follow => 4,
        :follower => 5,
        :ranking => 6
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Job".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Introduction".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
  end
end
