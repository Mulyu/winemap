

window.onload=function(){
  console.log("---- start ----");

  var windowX=window.innerWidth;
  var windowY=window.innerHeight;

  d3.select("#visArea")
     .attr("width", windowX)
     .attr("height", windowY);

  var svg = d3.select("#mapArea")
              .attr("transform","translate(100,0)scale("+((windowX-100)/2760)+","+((windowX-100)/2760)+")");

  //layoutWine("fr", 500, getWineData());

  //dropWine("#fr");
};

function renderMap(){


}

function getWineData(){
  var wines=[];

  var e = document.getElementById('wineArea');
  var tmpWine = e.getAttribute('data-winedata');
  tmpWine=JSON.parse(tmpWine);

  tmpWine.forEach(function(e,index){
    wines.push({"feature": "type"+e["winetype_id"], "name": e["name"], "value": e["winelevel"]});
  });

  //console.log("test : wines");
  //console.log(wines);

  return wines;
}

function makeWineData(){

  wines=[];
  for(var i=0 ; i<100 ; i++){
    var wine=[];
    var feature="";
    var wineName="";
    var value="";

    var tmpRand=Math.random();

    if(tmpRand<0.6)
      feature="red";
    else if(tmpRand<0.8)
      feature="white";
    else
      feature="rose";



    tmpRand=Math.random();

    if(tmpRand<0.2)
      wineName="Oishii";
    else if(tmpRand<0.4)
      wineName="Umai";
    else if(tmpRand<0.6)
      wineName="Sunngoi";
    else if(tmpRand<0.8)
      wineName="Kimotiii";
    else
      wineName="Hutuu";

    wineName+=(" Wine "+i);

    value=Math.random()*5;



    wine={"feature": feature, "name": wineName, "value": value};
    wines.push(wine);
  }

  return wines;
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
                    .attr("transform","translate(100,0)scale("+((windowX-100)/2760)+","+((windowX-100)/2760)+")");

    }, 200);
});