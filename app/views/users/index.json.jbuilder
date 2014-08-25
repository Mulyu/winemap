json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :password, :age, :gender, :prefecture, :home_prefecture_id, :job, :married, :introduction, :winelevel, :winenum, :follow, :follower, :ranking
  json.url user_url(user, format: :json)
end
