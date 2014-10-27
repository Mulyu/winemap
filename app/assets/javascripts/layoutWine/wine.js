function Wine(wineData){
  // ワインデータの格納
  this.id = wineData.wine_id;
  this.name = wineData.name;
  this.price = wineData.price;
  this.type = {
    id:         wineData.winetype_id,
    type:       wineData.winetype_name };
  this.year = wineData.year;
  this.productionDistrict = {
    names:      wineData.regions,
    winery:     wineData.winery,
    latitude:   wineData.latitude,
    longitude:  wineData.longitude };
  this.varieties = wineData.winevarieties;
  this.review = {
    score:      wineData.score,
    body:       wineData.body,
    sweetness:  wineData.sweetness };
  this.user = {
    name:       wineData.user,
    level:      wineData.winelevel };

  this.layoutPosition = [];
}

function computeWineLayoutPosition(wines){

  var productionDistrictNames = [];

  wines.forEach(function(wine){
    wine.productionDistrict.names.forEach(function(name, i){
      // todo : 生産地のレベル毎に地名を見て
      //        productionDistrictNamesを
      
      // todo : 地名がいくつあるかを見て
      //        wine.layoutPosition いれてく処理
      
      wine.layoutPosition[i]={
        latitude:  wine.productionDistrict.latitude,
        longitude: wine.productionDistrict.longitude
      };
    });
  });
}