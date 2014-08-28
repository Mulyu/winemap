

window.onload=function(){
  console.log("---- start ----");

  var windowX=window.innerWidth;
  var windowY=window.innerHeight;

  d3.select("#visArea")
     .attr("width", windowX)
     .attr("height", windowY);

  d3.selectAll(".renderArea")
      .attr("transform","translate(100,50)scale("+((windowX-100)/2760)+","+((windowX-100)/2760)+")");

  getWineData();

  dropWine("#wineArea");
};

function renderWine(){

}

function getWineData(){
  var europe_wines=[];
  var africa_wines=[];
  var asia_wines=[];
  var oceania_wines=[];
  var middle_east_wines=[];
  var north_america_wines=[];
  var outh_and_central_america_wines=[];

  var wineArea = d3.select("#wineArea");

  wineArea.append("g")
    .attr("id","europe")
    .attr("transform","translate(1380,270)");
  wineArea.append("g")
    .attr("id","africa")
    .attr("transform","translate(1330,570)");
  wineArea.append("g")
    .attr("id","asia")
    .attr("transform","translate(2050,500)");
  wineArea.append("g")
    .attr("id","oceania")
    .attr("transform","translate(2200,900)");
  wineArea.append("g")
    .attr("id","middle_east")
    .attr("transform","translate(1380,270)");
  wineArea.append("g")
    .attr("id","north_america")
    .attr("transform","translate(400,300)");
  wineArea.append("g")
    .attr("id","south_and_central_america")
    .attr("transform","translate(730,770)");

  var e = document.getElementById('wineArea');
  var tmpWine = e.getAttribute('data-winedata');
  tmpWine=JSON.parse(tmpWine);

  tmpWine.forEach(function(e,index){
    switch(e["worldregion_name"]){
      case "オセアニア":
        oceania_wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
        break;
      case "ヨーロッパ":
        europe_wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
        break;
      case "アジア":
        oceania_wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
        break;
      case "アフリカ":
        africa_wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
        break;
      case "中南米":
        outh_and_central_america_wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
        break;
      default:
        console.log(e["worldregion_name"]);
        africa_wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
        break;
    }
  });

  layoutWine("europe",200,europe_wines);
  layoutWine("africa",200,africa_wines);
  layoutWine("oceania",200,oceania_wines);
  layoutWine("south_and_central_america",200,outh_and_central_america_wines);

  //console.log("test : wines");
  //console.log(wines);

}



var timer = false;
$(window).resize(function() {
    if (timer !== false) {
        clearTimeout(timer);
    }
    timer = setTimeout(function() {
        var windowX=window.innerWidth;
        var windowY=window.innerHeight;

        d3.select("#visArea")
           .attr("width", windowX)
           .attr("height", windowY);

        var svg = d3.select("#mapArea")
                    .attr("transform","translate(100,50)scale("+((windowX-100)/2760)+","+((windowX-100)/2760)+")");

    }, 200);
});