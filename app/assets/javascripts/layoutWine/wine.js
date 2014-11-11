function Wine(wineData){

  // ワインデータの格納
  this.id = wineData.wine_id;
  this.name = wineData.name;
  this.price = wineData.price;
  this.type = {
    id:         wineData.winetype_id,
    name:       wineData.winetype_name };
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


  this.setInfoToDetailArea = function(){
    var detailAreaElement = d3.select("#detailArea");

    detailAreaElement.select("#name").select("span")
      .text(this.name);

    detailAreaElement.select("#type").select("span")
      .text(this.type.name)
      .attr("onclick","wineFilterByType('"+this.type.name+"');");

    detailAreaElement.select("#price").select("span")
      .text(this.price);

    detailAreaElement.select("#score").select("span")
      .text(this.review.score);

    detailAreaElement.select("#year").select("span")
      .text(this.year);
  };

  this.getIconImagePath = function(){
    // todo : ワインのscore(this.review.score)に合わせてreturnの内容を変える
    
    switch(this.type.id){
      case 1:
        return "/assets/wine/smallRed.png";
      case 2:
        return "/assets/wine/smallWhite.png";
      case 3:
        return "/assets/wine/smallRose.png";
      case 4:
        return "/assets/wine/smallSpark.png";
      case 5:
        return "/assets/wine/smallDesart.png";
      default:
        return "/assets/wine/smallDefault.png";
    }
  };
}

function wineFilterByType( type ){
  wines.forEach(function(wine){
    if(wine.type.name != type){
      wine.marker.setVisible(false);
    }
  });
}

function wineFilter(){
  wines.forEach(function(wine){
    wine.marker.setVisible(true);

    if( ( wine.review.score < scoreSlider.getLeftHandleValue() ) ||
        ( wine.review.score > scoreSlider.getRightHandleValue() ) ){
      wine.marker.setVisible(false);
      return;
    }

    if( wine.price !== null)
      if( ( wine.price < priceSlider.getLeftHandleValue() ) ||
          ( wine.price > priceSlider.getRightHandleValue() ) ){
        wine.marker.setVisible(false);
        return;
      }

    if( wine.year !== null)
      if( ( wine.year < yearSlider.getLeftHandleValue() ) ||
          ( wine.year > yearSlider.getRightHandleValue() ) ){
        wine.marker.setVisible(false);
        return;
      }
  });
}

function changeVisFilterArea(){
  if( d3.select("#filterShowInput").property("checked") )
    appendArea("filterArea", 0.7);
  else
    hiddenArea("filterArea");
}

function showCreateArea(){
  appendArea("createWineArea", 1);
  useAjax("createWineForm");
}