function Wine(wineData){

  var that = this;

  // ワインデータの格納
  this.id = wineData.id;
  this.name = wineData.name;
  this.price = wineData.price;
  this.type = {
    id:         wineData.winetype_id,
    name:       wineData.winetype_name };
  this.year = wineData.year;
  this.productionDistrict = {
    names:      [].concat(wineData.regions),
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
    switch(this.type.id){
      case 1:
        return "/assets/wine/red"+this.review.score.toString()+"_wide.png";
      case 2:
        return "/assets/wine/white"+this.review.score.toString()+"_wide.png";
      case 3:
        return "/assets/wine/rose"+this.review.score.toString()+"_wide.png";
      case 4:
        return "/assets/wine/sparkling"+this.review.score.toString()+"_wide.png";
      case 5:
        return "/assets/wine/dessert"+this.review.score.toString()+"_wide.png";
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
    if( names.length > 3 )
      names = names.slice(0, 4);

    detailAreaElement.select(".region").select("span")
      .text( names.join(" ") );

    detailAreaElement.select(".type").select("span")
      .attr("onClick","wineFilterByType('"+that.type.name+"');")
      .text(that.type.name)
      .append("span")
      .text("タイプでフィルターする");

    detailAreaElement.select(".price").select("span")
      .text(that.price);

    detailAreaElement.select(".score").select("span")
      .text(that.review.score);

    detailAreaElement.select(".year").select("span")
      .text(that.year);

    if( that.user.id == 1 ){
      detailAreaElement.select(".user").select("a")
        .text(that.user.name)
        .classed("entryUser",false)
        .attr("href","javascript:void(0)");
    }else{
      detailAreaElement.select(".user").select("a")
        .text(that.user.name)
        .classed("entryUser",true)
        .attr("href","/users/"+that.user.id)
        .append("span")
        .text("ユーザーページへ");
    }

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
  console.log("どんどん");
  wines.forEach( function(wine){
    if("infoWindow" in wine)
      wine.infoWindow.close();
  });
}

function wineFilterByType( type ){
  d3.select("#filterShowInput")
    .property("checked",true);
  changeVisFilterArea();

  d3.select("#typeFilter").selectAll("input")
    .property("checked",false);

  filterMap.red = false;
  filterMap.white = false;
  filterMap.rose = false;
  filterMap.sparkling = false;
  filterMap.dessert = false;

  switch(type){
    case "赤":
      d3.select("#typeRed")
        .property("checked",true);
      filterMap.red = true;
      break;
    case "白":
      d3.select("#typeWhite")
        .property("checked",true);
      filterMap.white = true;
      break;
    case "ロゼ":
      d3.select("#typeRose")
        .property("checked",true);
      filterMap.rose = true;
      break;
    case "スパークリング":
      d3.select("#typeSpark")
        .property("checked",true);
      filterMap.sparkling = true;
      break;
    case "デザート":
      d3.select("#typeDesart")
        .property("checked",true);
      filterMap.dessert = true;
      break;
  }
  wineFilter();
}

function wineFilter(){
  wines.forEach(function(wine){
    wine.marker.setVisible(true);

    if( !filterMap.red && ( wine.type.id == 1 ) ){
      wine.marker.setVisible(false);
      return;
    }

    if( !filterMap.white && ( wine.type.id == 2 ) ){
      wine.marker.setVisible(false);
      return;
    }

    if( !filterMap.rose && ( wine.type.id == 3 ) ){
      wine.marker.setVisible(false);
      return;
    }

    if( !filterMap.sparkling && ( wine.type.id == 4 ) ){
      wine.marker.setVisible(false);
      return;
    }

    if( !filterMap.dessert && ( wine.type.id == 5 ) ){
      wine.marker.setVisible(false);
      return;
    }

    if( !filterMap.price && ( wine.price === null ) ){
      wine.marker.setVisible(false);
      return;
    }

    if( !filterMap.year && ( wine.year === null ) ){
      wine.marker.setVisible(false);
      return;
    }

    if( !filterMap.mine && ( wine.user.id !== userData.id ) ){
      wine.marker.setVisible(false);
      return;
    }

    if( (filterMap.name!=="") && ( wine.user.name.search(filterMap.name)===(-1) ) ){
      wine.marker.setVisible(false);
      return;
    }


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
    d3.select("#moreField")
      .transition()
      .style("height","400px");
  }else{
    d3.select("#moreField")
      .transition()
      .style("height","0px");
  }
}