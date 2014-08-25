require 'rails_helper'

RSpec.describe "users/show", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Password/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Job/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Introduction/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
  end
end
