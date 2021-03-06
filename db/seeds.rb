# coding: utf-8

require "csv"

### 初期データ投入


# seed stocktable
`mysql --local-infile=1  -u root -p winemap_dev < db/stocktable.sql `

# worldregions
Worldregion.create(name: '不明')
CSV.foreach('db/seed_csv/worldregions.csv') do |row|
  Worldregion.create(
    name: row[0],
    )
end

# countries
Country.create(name: '不明', ranking: 0, svg_id: 'ukn', center_x: 100.12345, center_y: 100.12345, worldregion_id: 1)
CSV.foreach('db/seed_csv/countries.csv') do |row|
  Country.create(
    name: row[0],
    ranking: row[1],
    svg_id: row[2],
    center_x: row[3],
    center_y: row[4],
    worldregion_id: row[5]
    )
end

# countrycodes
CSV.foreach('db/seed_csv/countrycodes.csv') do |row|
  Countrycode.create(
    code: row[0],
    country_id: row[1]
    )
end

# localregions
CSV.foreach('db/seed_csv/localregions_heroku.csv') do |row|
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
#CSV.foreach('db/seed_csv/situationswines.csv') do |row|
#  situations_winses=Situationswine.create(
#    wine_id: row[0],
#    situation_id: row[1]
#    )
#end

# situations
CSV.foreach('db/seed_csv/situations.csv') do |row|
  Situation.create(
    name: row[0]
    )
end

# wines
CSV.foreach('db/seed_csv/wines_heroku.csv') do |row|
  Wine.create(
    name: row[0],
    country_id: row[1],
    localregion_id: row[2],
    latitude: row[3],
    longitude: row[4],
    body: row[5],
    sweetness: row[6],
    sourness: row[7],
    winetype_id: row[8],
    year: row[9],
    photo: row[10],
    score: row[11],
    price: row[12],
    winery: row[13],
    user_id: row[14],
    winelevel: row[15],

    # for validation error
    input_region: "testregion"

    )
end

# users
CSV.foreach('db/seed_csv/users_heroku.csv') do |row|
  User.create(
    name: row[0],
    gender: row[4],
    prefecture_id: row[5],
    home_prefecture_id: row[6],
    job: row[7],
    married: row[8],
    introduction: row[9],
    winelevel: row[10],
    follow: row[12],
    follower: row[13],
    ranking: row[14],
    logininfo_id: row[15],
    birth: '1990-01-01'

    )
end

# logininfo
CSV.foreach('db/seed_csv/logininfos.csv') do |row|
    Logininfo.create(
        email: row[0],
        password: row[1],
        password_confirmation: row[2]
    )
end

# prefectures
CSV.foreach('db/seed_csv/prefectures.csv') do |row|
  Prefecture.create(
    name: row[0],
    prefectureregion_id: row[1]
    )
end

# prefectures
CSV.foreach('db/seed_csv/prefectureregions.csv') do |row|
  Prefectureregion.create(
    name: row[0]
    )
end

# Follows
CSV.foreach('db/seed_csv/follows.csv') do |row|
    Follow.create(
    from_user_id: row[0],
    to_user_id: row[1]
    )
end
