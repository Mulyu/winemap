var windowX=window.innerWidth;
var windowY=window.innerHeight;

var wineSize=0;

var regionNameMap=[];


window.onload=function(){
  console.log("---- start ----");

  regionNameAdd();

  d3.select("#visArea")
     .attr("width", windowX)
     .attr("height", windowY);

  d3.selectAll(".renderArea")
      .attr("transform","translate(100,50)scale("+((windowX-100)/2760)+","+((windowX-100)/2760)+")");

  renderWine();
};


function renderWine(){
  var undefine_wines=[];
  var undefine_wines_size=0;
  var europe_wines=[];
  var europe_wines_size=0;
  var africa_wines=[];
  var africa_wines_size=0;
  var asia_wines=[];
  var asia_wines_size=0;
  var oceania_wines=[];
  var oceania_wines_size=0;
  var middle_east_wines=[];
  var middle_east_wines_size=0;
  var north_america_wines=[];
  var north_america_wines_size=0;
  var south_and_central_america_wines=[];
  var south_and_central_america_wines_size=0;

  var e = document.getElementById('wineData');
  var tmpWine = e.getAttribute('data-winedata');
  tmpWine=JSON.parse(tmpWine);

  tmpWine.sort(function(a,b){
    var typeA = a["winetype_id"];
    var typeB = b["winetype_id"];
    if(typeA<typeB) return -1;
    if(typeA>typeB) return 1;
    return 0;
  });

  wineSize=800/Math.sqrt(tmpWine.length);

  tmpWine.forEach(function(e,index){
    switch(e["worldregion_id"]){
      case 1:
        console.log("不明");
        undefine_wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
        undefine_wines_size+=e["winelevel"];
        break;
      case 7:
        oceania_wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
        oceania_wines_size+=e["winelevel"];
        break;
      case 4:
        europe_wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
        europe_wines_size+=e["winelevel"];
        break;
      case 3:
        asia_wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
        asia_wines_size+=e["winelevel"];
        break;
      case 2:
        africa_wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
        africa_wines_size+=e["winelevel"];
        break;
      case 5:
        north_america_wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
        north_america_wines_size+=e["winelevel"];
        break;
      case 6:
        south_and_central_america_wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
        south_and_central_america_wines_size+=e["winelevel"];
        break;
      default:
        console.log(e["worldregion_id"]);
        africa_wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
        africa_wines_size+=e["winelevel"];
        break;
    }
  });

  layoutWine("undefine",Math.sqrt(undefine_wines_size)*wineSize,undefine_wines);
  layoutWine("europe",Math.sqrt(europe_wines_size)*wineSize,europe_wines);
  layoutWine("asia",Math.sqrt(asia_wines_size)*wineSize,asia_wines);
  layoutWine("africa",Math.sqrt(africa_wines_size)*wineSize,africa_wines);
  layoutWine("oceania",Math.sqrt(oceania_wines_size)*wineSize,oceania_wines);
  layoutWine("south_and_central_america",Math.sqrt(south_and_central_america_wines_size)*wineSize,south_and_central_america_wines);
  layoutWine("north_america",Math.sqrt(north_america_wines_size)*wineSize,north_america_wines);

  dropWine(tmpWine.length);
}


function regionNameAdd(){
  regionNameMap["europe"]="ヨーロッパ";
  regionNameMap["africa"]="アフリカ";
  regionNameMap["asia"]="アジア";
  regionNameMap["oceania"]="オセアニア";
  regionNameMap["south_and_central_america"]="中南米";
  regionNameMap["north_america"]="北米";
  regionNameMap["undefine"]="不明";
}



var timer = false;
$(window).resize(function() {
    if (timer !== false) {
        clearTimeout(timer);
    }
    timer = setTimeout(function() {
        windowX=window.innerWidth;
        windowY=window.innerHeight;

        d3.select("#visArea")
           .attr("width", windowX)
           .attr("height", windowY);

        d3.selectAll(".renderArea")
          .attr("transform","translate(100,50)scale("+((windowX-100)/2760)+","+((windowX-100)/2760)+")");

    }, 200);
});