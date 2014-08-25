require 'rails_helper'

RSpec.describe "users/new", :type => :view do
  before(:each) do
    assign(:user, User.new(
      :name => "MyString",
      :email => "MyString",
      :password => "MyString",
      :age => 1,
      :gender => 1,
      :prefecture => "",
      :home_prefecture => nil,
      :job => "MyString",
      :married => "",
      :introduction => "MyString",
      :winelevel => 1.5,
      :winenum => 1,
      :follow => 1,
      :follower => 1,
      :ranking => 1
    ))
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do

      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_password[name=?]", "user[password]"

      assert_select "input#user_age[name=?]", "user[age]"

      assert_select "input#user_gender[name=?]", "user[gender]"

      assert_select "input#user_prefecture[name=?]", "user[prefecture]"

      assert_select "input#user_home_prefecture_id[name=?]", "user[home_prefecture_id]"

      assert_select "input#user_job[name=?]", "user[job]"

      assert_select "input#user_married[name=?]", "user[married]"

      assert_select "input#user_introduction[name=?]", "user[introduction]"

      assert_select "input#user_winelevel[name=?]", "user[winelevel]"

      assert_select "input#user_winenum[name=?]", "user[winenum]"

      assert_select "input#user_follow[name=?]", "user[follow]"

      assert_select "input#user_follower[name=?]", "user[follower]"

      assert_select "input#user_ranking[name=?]", "user[ranking]"
    end
  end
end
