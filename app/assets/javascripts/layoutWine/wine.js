function Wine(wineData){

  var that = this;

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
    id:         wineData.user_id,
    name:       wineData.user,
    level:      wineData.winelevel };

  this.detailHtml = getDetailHtml();

  this.getIconImagePath = function(){
    // todo : ワインのscore(this.review.score)に合わせてreturnの内容を変える
    switch(this.type.id){
      case 1:
        return "/assets/wine/red"+this.review.score.toString()+".png";
      case 2:
        return "/assets/wine/white"+this.review.score.toString()+".png";
      case 3:
        return "/assets/wine/rose"+this.review.score.toString()+".png";
      case 4:
        return "/assets/wine/sparkling"+this.review.score.toString()+".png";
      case 5:
        console.log("dessert"+this.review.score.toString());
        return "/assets/wine/dessert"+this.review.score.toString()+".png";
      default:
        return "/assets/wine/defaultSmall.png";
    }
  };

  this.showInfo = function( map ){
      that.infoWindow = new google.maps.InfoWindow({
        content: this.detailHtml
      });

      that.infoWindow.open(map, that.marker);
  };

  function getDetailHtml(){
    setInfoToDetailArea();

    var html = d3.select("#detailTemplateArea")
                  .select("div").node().cloneNode(true);

    return html;
  }

  function setInfoToDetailArea(){
    var detailAreaElement = d3.select("#detailTemplateArea");

    detailAreaElement.select(".name").select("span")
      .text(that.name);

    var names = that.productionDistrict.names;
    if( names.length >3 )
      names = names.slice(0, 4);

    detailAreaElement.select(".region").select("span")
      .text( names );

    detailAreaElement.select(".type").select("span")
      .text(that.type.name)
      .attr("onclick","wineFilterByType('"+that.type.name+"');");

    detailAreaElement.select(".price").select("span")
      .text(that.price);

    detailAreaElement.select(".score").select("span")
      .text(that.review.score);

    detailAreaElement.select(".year").select("span")
      .text(that.year);

    if( ( that.user.id == 1 )||( that.user.id == userData.id ) ){
      detailAreaElement.select(".wineEditLinkArea")
        .attr("action", "wines/"+that.id)
        .style("display","block");

      detailAreaElement.select(".wineEditLink")
        .attr("href","wines/"+that.id+"/edit");

      detailAreaElement.select(".wineDeleteLink")
        .attr("href","wines/"+that.id);
    }else{
      detailAreaElement.select(".wineEditLinkArea")
        .style("display","none");
    }
  }
}

function hiddenWineDetail(){
  wines.forEach( function(wine){
    if("infoWindow" in wine)
      wine.infoWindow.close();
  });
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

    if( ( wine.price !== null ) && ( wine.price !== "") )
      if( ( wine.price < priceSlider.getLeftHandleValue() ) ||
          ( wine.price > priceSlider.getRightHandleValue() ) ){
        wine.marker.setVisible(false);
        return;
      }

    if( ( wine.year !== null ) && ( wine.year !== "")  )
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

function changeMoreInfoArea(){
  if( d3.select("#moreInfoInput").property("checked") ){
    appendArea("moreField", 1);
    d3.select("#moreField").style("display","block");
  }else{
    hiddenArea("moreField");
    d3.select("#moreField").style("display","none");
  }
}