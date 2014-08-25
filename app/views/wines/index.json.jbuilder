json.array!(@wines) do |wine|
  json.extract! wine, :id, :name, :country_id, :localregions_id, :svg_x, :svg_y, :body, :sweetness, :sourness, :winetype_id, :year, :winevariety_id, :photopath, :score, :price, :winery, :user_id, :winelevel
  json.url wine_url(wine, format: :json)
end
