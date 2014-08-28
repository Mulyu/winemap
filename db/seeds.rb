# coding: utf-8

 #Country.create name: 'japan' , ranking: 10 , svg_id: 1 , worldregion_id: 3
 #Worldregion.create name: 'east asia' , center_x: 10.0 , center_y: 10.0

require "csv"

### 初期データ投入

# worldregions
CSV.foreach('db/seed_csv/worldregions.csv') do |row|
  Worldregion.create(
    name: row[0],
    )
end

# countries
CSV.foreach('db/seed_csv/countries.csv') do |row|
  Country.create(
    name: row[0],
    ranking: row[1],
    svg_id: row[2],
    worldregion_id: row[3]
    )
end

# localregions
CSV.foreach('db/seed_csv/localregions.csv') do |row|
  Localregion.create(
    name: row[0],
    ranking: row[1],
    country_id: row[2]
    )
end

# winetypes
CSV.foreach('db/seed_csv/winetypes.csv') do |row|
  Winetype.create(
    name: row[0]
    )
end

# winevarieties
CSV.foreach('db/seed_csv/winevarieties.csv') do |row|
  Winevariety.create(
    name: row[0]
    )
end

# situationswines
CSV.foreach('db/seed_csv/situationswines.csv') do |row|
  situations_winses=Situationswine.create(
    wine_id: row[0],
    situation_id: row[1]
    )
end
# situations
CSV.foreach('db/seed_csv/situations.csv') do |row|
  Situation.create(
    name: row[0]
    )
end

# wines
CSV.foreach('db/seed_csv/wines.csv') do |row|
  Wine.create(
    name: row[0],
    country_id: row[1],
    localregion_id: row[2],
    svg_latitude: row[3],
    svg_longitude: row[4],
    body: row[5],
    sweetness: row[6],
    sourness: row[7],
    winetype_id: row[8],
    year: row[9],
    photopath: row[10],
    score: row[11],
    price: row[12],
    winery: row[13],
    user_id: row[14],
    winelevel: row[15]
    )
end

# users
CSV.foreach('db/seed_csv/users.csv') do |row|
  User.create(
    name: row[0],
    email: row[1],
    password: row[2],
    age: row[3],
    gender: row[4],
    prefecture_id: row[5],
    home_prefecture_id: row[6],
    job: row[7],
    married: row[8],
    introduction: row[9],
    winelevel: row[10],
    winenum: row[11],
    follow: row[12],
    follower: row[13],
    ranking: row[14],
    
    # for validation error 
    country_or_region: 1
    )
end

# prefectures
CSV.foreach('db/seed_csv/prefectures.csv') do |row|
  Prefecture.create(
    name: row[0]
    )
end

# usersusers
# CSV.foreach('db/seed_csv/usersusers.csv') do |row|
#   UsersUser.create(
#     from_user_id: row[0],
#     to_user_id: row[1]
#     )
# end