

function layoutWine(tagId, areaSize, wines){
  console.log("---- Layout Start ----");
  
  var element = document.getElementById(tagId);

  var format = d3.format(",d"),
  color = d3.scale.category10();

  var bubble = d3.layout.pack()
    .sort(null)
    .size([areaSize, areaSize])
    .padding(20);

  var area = d3.select("#"+tagId);

  //console.log(element);

  var svg=area.append("g")
    .attr("id",tagId+"_wineArea")
    .attr("width", areaSize)
    .attr("height", areaSize)
    .attr("class", "bubble");

  var areaId="#"+tagId+"_wineArea";

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
      .attr("transform", function(d){return "translate("+(d.x-areaSize/2)+","+(d.y-areaSize*10)+")";})
      .attr("x", function(d){return d.x-areaSize/2;})
      .attr("y", function(d){return d.y-areaSize/2;})
      .attr("scale", function(d){return d.r/40;});

  node.append("title")
      .text(function(d) { return d.className; });

  node.append("path")
      .attr("d","m-7,-198.5l20,0l0,60c2,50.66667 24.5,49.33334 27.5,110l0,130l-80,0l0,-130c1.66666,-59 30.83334,-59 32.5,-110l0,-60z")
      .attr("transform", function(d){return "scale("+d.r/40+","+d.r/40+")";})
      .attr("class",function(d) {return d.packageName;});

  node.append("text")
      .attr("dy", ".3em")
      .style("text-anchor", "middle")
      .text(function(d) { return d.className; })
      .attr("class",function(d) {return d.packageName;});

  $(areaId).html(
    $(areaId+"> g").sort(function(a,b){
      return parseInt($(a).attr("y"),10) - parseInt($(b).attr("y"), 10);
    })
  );

}

function dropWine(tagId){
  svg=d3.select(tagId);

  svg.selectAll(".wine")
      .transition()
      .duration(750)
      .delay(function(d, i) { return i * 5; })
      .attr("transform", function(d,i){
        return "translate("+(d.x-100)+","+(d.y-100)+")";
      });
}