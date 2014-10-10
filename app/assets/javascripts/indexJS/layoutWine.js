function Wine(id, name, price, type, year, location, review, user){
  this.id = id;
  this.name = name;
  this.price = price;
  this.type = type;
  this.year = year;
  this.location = location;
  this.review = review;
  this.user = user;
}

function setWineData(wineData){
  var wines=[];

  wineData.forEach(function(wine){
    wines.push(new Wine(
      wine.wine_id,
      wine.name,
      wine.price,
      { id:         wine.winetype_id,
        type:       wine.winetype_name },
      wine.year,
      { names:      [ wine.worldregion_id,
                      wine.country_name ],
        winery:     wine.winery,
        latitude:   wine.svg_latitude,
        longitude:  wine.longitude },
      { score:      wine.score,
        body:       wine.body,
        sweetness:  wine.sweetness },
      { name:       wine.user,
        level:      wine.winelevel}
    ));
  });

  return wines;
}


function layoutWine(tagId, areaSize, wines){
  console.log("---- Layout Start : "+tagId+" ----");

  createRegionCircle(tagId, areaSize);

  var format = d3.format(",d");

  var bubble = d3.layout.pack()
    .sort(null)
    .size([areaSize, areaSize])
    .padding(200);

  var svg=d3.select("#"+tagId).append("g")
    .attr("id",tagId+"_wineArea")
    .attr("width", areaSize)
    .attr("height", areaSize)
    .attr("class", "bubble")
    .attr("transform","translate("+(-areaSize/2)+","+(-areaSize/4)+")scale(1,0.6)");



  var classes=[];
  wines.forEach(function(e,index){
    classes.push({packageName: "winePath "+e["feature"], className: e["name"], value: e["value"]});
  });

  var node=svg.selectAll(".node")
    .data(bubble.nodes({children:classes}))
    .enter().append("g")
      .attr("id",function(d){return d.className;})
      .attr("class","wine")
      .filter(function(d) {return !d.children;})
      .attr("transform", function(d){return "translate("+(d.x)+","+(d.y-areaSize*20)+")";})
      .attr("y", function(d){return d.y;});

  node.append("title")
      .text(function(d) { return d.className; });

  node.append("path")
      .attr("onclick",function(d){
        return "location.href='wines/"+wineData[d.className]["wine_id"]+"'";})
      .attr("d","m-5,-302.5l20,0l0,60c2,50.66667 24.5,49.33334 27.5,110l0,130l-80,0l0,-130c1.66666,-59 30.83334,-59 32.5,-110l0,-60z")
      .attr("transform", function(d){return "scale("+wineSize/200*(d.value+0.2)+","+wineSize/200*(d.value+0.2)*1.6+")";})
      .attr("class",function(d) {return d.packageName;});

  node.append("text")
      .attr("dy", "2em")
      .style("text-anchor", "middle")
      .text(function(d) { return wineData[d.className]["name"]; })
      .attr("transform","scale(1,1.6)")
      .attr("class",function(d) {return d.packageName;});

  wineTagSort(tagId);
}


function createRegionCircle(tagId, areaSize){
  d3.select("#"+tagId).append("circle")
    .attr("cx","0")
    .attr("cy","0")
    .attr("r", areaSize/1.5)
    .attr("transform","scale(1,0.6)")
    .attr("class","regionCircle");

  d3.select("#"+tagId).append("text")
    .attr("dx",areaSize/1.5+30)
    .text(regionNameMap[tagId])
    .attr("class","regionText");
}


function wineTagSort(tagId){
  var element = document.getElementById(tagId);
  var areaId="#"+tagId+"_wineArea";

  $(areaId).html(
    $(areaId+"> g").sort(function(a,b){
      return parseInt($(a).attr("y"),10) - parseInt($(b).attr("y"), 10);
    })
  );
}




function dropWine(num){
  svg=d3.select("#wineArea");

  svg.selectAll(".wine")
      .transition()
      .duration(750)
      .delay(function(d, i) { return i*1000/num; })
      .attr("transform", function(d,i){
        return "translate("+(d.x)+","+(d.y)+")";
      });
}