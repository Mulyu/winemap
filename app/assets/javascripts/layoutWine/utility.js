
function enableUpdateVisAreaSize(domId){
  var HEIGHT_OF_HEIGHT_PLUS_FOOTER = 140; // 適当です

  var windowSizingTimer = false;
  d3.select("#"+domId)
  .attr("style", "width:"+windowX+"px; height:"+(windowY-HEIGHT_OF_HEIGHT_PLUS_FOOTER)+"px");

  $(window).resize(function() {
    if (windowSizingTimer !== false) {
      clearTimeout(windowSizingTimer);
    }
    windowSizingTimer = setTimeout(function() {
      windowX=window.innerWidth;
      windowY=window.innerHeight;

      d3.select("#"+domId)
      .attr("style", "width:"+windowX+"px; height:"+(windowY-HEIGHT_OF_HEIGHT_PLUS_FOOTER)+"px");

    }, 200);
  });
}