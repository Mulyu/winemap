
function enableUpdateVisAreaSize(domId){
  var HEIGHT_OF_HEADER_PLUS_FOOTER = 140; // 適当な値に設定してます

  var windowSizingTimer = false;
  d3.select("#"+domId)
  .attr("style", "width:"+windowX+"px; height:"+(windowY-HEIGHT_OF_HEADER_PLUS_FOOTER)+"px");

  $(window).resize(function() {
    if (windowSizingTimer !== false) {
      clearTimeout(windowSizingTimer);
    }
    windowSizingTimer = setTimeout(function() {
      windowX=window.innerWidth;
      windowY=window.innerHeight;

      d3.select("#"+domId)
      .attr("style", "width:"+windowX+"px; height:"+(windowY-HEIGHT_OF_HEADER_PLUS_FOOTER)+"px");

    }, 200);
  });
}