
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

function appendArea( domId ){
    var area = d3.select("#"+domId);

    area.style("display","block");

    area.transition()
      .style("opacity","0.7");
}

function hiddenArea( domId ){
    var area = d3.select("#"+domId);

    area.transition()
      .style("opacity","0");

    area.style("display","none");
}

function useAjax( domId ){
  $.ajax({
    url: "wines/new",
    dataType: "html",
    cache: false,
    success: function(data, textStatus){
      $("#"+domId).html(data);
    },
    error: function(xhr, textStatus, errorThrown){
      // エラー処理
    }
  });
}