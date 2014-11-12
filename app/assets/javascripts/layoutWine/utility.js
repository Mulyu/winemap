
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

function appendArea( domId , opacityValue){
    var area = d3.select("#"+domId);

    area.style("pointer-events","auto");

    area.transition()
      .style("opacity",opacityValue);
}

function hiddenArea( domId ){
    var area = d3.select("#"+domId);

    area.transition()
      .style("opacity","0");

    area.style("pointer-events","none");
}

function useAjax( domId ){
  $.ajax({
    url: "wines/new",
    dataType: "html",
    cache: false,
    success: function(data, textStatus){
      $("#"+domId).html(data);

      $(function($){
        $("#new_wine")
        .bind("ajax:complete", function(){
          dropPin();

          hiddenArea("createWineArea");
          // todo : ピンを落とす処理を書く
          //       入力したwineの情報が欲しいでござる
        });
      });
      
      $("#createWineArea").click(function(e){
        var target = e.target;
        if (target.id === 'createWineArea') {
          hiddenArea("createWineArea");
      
          d3.select("#new_wine").remove();

          return false;
        }
      });
    },
    error: function(xhr, textStatus, errorThrown){
      // エラー処理
    }
  });
}

function dropPin() {
  var geocoder = new google.maps.Geocoder();

  var address = d3.select("#wine_input_region").node().value;

  geocoder.geocode( { 'address': address}, function(results, status) {

    if (status == google.maps.GeocoderStatus.OK) {
      var latlng = results[0].geometry.location;

      wineData = {
        body:            3,
        latitude:        latlng.lat(),
        longitude:       latlng.lng(),
        name:            d3.select("#wine_name").node().value,
        price:           d3.select("#wine_price").node().value,
        region:          [],
        score:           3,
        sweetness:       3,
        user:            "guest",
        wine_id:         null,
        winelevel:       null,
        winery:          d3.select("#wine_winery").node().value,
        winetype_id:     d3.select("#wine_winetype_id").node().selectedIndex,
        winetype_name:   d3.select("#wine_winetype_id").selectAll("option")[0][d3.select("#wine_winetype_id").node().selectedIndex].value,
        winevarieties:   [],
        year:            d3.select("#wine_year").node().value
      };

      var wine = new Wine(wineData);
      wines.push( wine );

      setMarker( googleMap, wine );
      
      d3.select("#new_wine").remove();


    // ジオコーディングが成功しなかった場合
    } else {
      console.log('Geocode was not successful for the following reason: ' + status);
          d3.select("#new_wine").remove();
    }
    
  });

}






function TwoHandleSlider( d3Element, sliderId ){

  var styleParam = {
    width:      400,
    height:     50
  };



  var dragEvents = d3.behavior.drag()
    .on("drag", function(d,i){
      var value = computePosToValue( d3.event.x );
      var left_or_right = d3.select(this).classed("leftHandle")? "left" : "right" ;

      sliderValue[ left_or_right+"Value" ] = value;

      normalValue( left_or_right );

      d3.select(this)
        .style("left", getHandlePosition( left_or_right )+"px");

      draggingFunctions.forEach( function( f ){
        f();
      });
    })
    .on("dragend", function(d,i){
      dragEndFunctions.forEach( function( f ){
        f();
      });
    });

  var HANDLE_SIZE = 40;
  var BORDER_WEIGHT = 2;
  var MARGIN = 60;
  var HEIGHT = MARGIN+HANDLE_SIZE;
  var FONT_SIZE = 15;

  var sliderValue = {
    minValue:   1,
    maxValue:   5,
    leftValue:    1,
    rightValue:   5
  };

  var element = d3Element.append("div")
            .attr("id",sliderId)
            .classed("twoHandleSlider",true)
            .style("position","relative")
            .style("backgrount-color","red")
            .style("height",HEIGHT+"px")
            .style("width",styleParam.width+"px");

  var draggingFunctions = [];
  var dragEndFunctions = [];

  defineFunctions( this );

  makeAxis();

  makeHandle( this, "left" );

  makeHandle( this, "right" );

  showHandleValue();

  draggingFunctions.push( function(){
    showHandleValue();
  });


  function makeAxis(){
    var AXIS_HEIGHT = 10;

    var axis = element
      .append("div")
      .style("position","absolute")
      .style("top", (MARGIN/2+HANDLE_SIZE-AXIS_HEIGHT)+"px")
      .style("left", MARGIN+"px")
      .style("height",(AXIS_HEIGHT)+"px")
      .style("width",(styleParam.width-MARGIN*2-BORDER_WEIGHT*2)+"px")
      .style("border",BORDER_WEIGHT+"px solid white")
      .style("border-top","none")
      .classed("sliderAxis",true);

    axis.append("div")
      .style("float","left")
      .style("margin-top",AXIS_HEIGHT/2+"px")
      .style("height",AXIS_HEIGHT/2+"px")
      .style("width","1px");

    for( var i=0 ; i<3 ; i++){
      axis.append("div")
        .style("float","left")
        .style("margin-top",AXIS_HEIGHT/2+"px")
        .style("height",AXIS_HEIGHT/2+"px")
        .style("width",((styleParam.width-MARGIN*2-BORDER_WEIGHT*2)/4-BORDER_WEIGHT)+"px")
        .style("border-right",BORDER_WEIGHT+"px solid white");
    }

    element
      .append("div")
      .classed("minValue",true)
      .style("font-size",FONT_SIZE+"px")
      .style("position","absolute")
      .style("top", (MARGIN/2+HANDLE_SIZE+AXIS_HEIGHT)+"px")
      .style("left", MARGIN+"px")
      .text(convertValueToDate(sliderValue.minValue));


    element
      .append("div")
      .classed("maxValue",true)
      .style("font-size",FONT_SIZE+"px")
      .style("position","absolute")
      .style("top", (MARGIN/2+HANDLE_SIZE+AXIS_HEIGHT)+"px")
      .style("right",MARGIN+"px")
      .text(convertValueToDate(sliderValue.maxValue));
  }

  function makeHandle( slider, left_or_right ){
    var handleElement = element
      .append("div")
      .style("position","absolute")
      .style("top", MARGIN/2+"px")
      .style("left", getHandlePosition( left_or_right )+"px")
      .style("width",(HANDLE_SIZE/2-2)+"px")
      .style("height",HANDLE_SIZE+"px")
      .style("border-"+(left_or_right=="left"? "right":"left"),"2px solid white")
      .classed("handle",true)
      .classed(left_or_right+"Handle",true)
      .call( dragEvents );

    handleElement
      .append("div")
      .style("cursor","move")
      .style("position","absolute")
      .style((left_or_right=="left"? "right":"left"), "0px")
      .style("padding","3px")
      .style("background-color","white")
      .style("font-size",FONT_SIZE+"px")
      .style("color", "black");
  }

  function convertValueToDate( value ){
    return value;
  }

  function showHandleValue(){
    element.select(".leftHandle").select("div")
      .text( convertValueToDate(parseInt( sliderValue.leftValue ,10)) );
    element.select(".rightHandle").select("div")
      .text( convertValueToDate(parseInt( sliderValue.rightValue ,10)) );
  }

  function getHandlePosition( left_or_right ){
    if( left_or_right == "left")
      return MARGIN+(styleParam.width - MARGIN*2)*(sliderValue.leftValue-sliderValue.minValue)/(sliderValue.maxValue-sliderValue.minValue)-HANDLE_SIZE/2+2;
    if( left_or_right == "right")
      return MARGIN+(styleParam.width - MARGIN*2)*(sliderValue.rightValue-sliderValue.minValue)/(sliderValue.maxValue-sliderValue.minValue)-2;
    return null;
  }



  function normalValue( left_or_right ){
    sliderValue[ left_or_right+"Value" ] = Math.round( sliderValue[ left_or_right+"Value" ] );

    if( sliderValue[ left_or_right+"Value" ] < sliderValue.minValue )
      sliderValue[ left_or_right+"Value" ] = sliderValue.minValue;
    
    if( sliderValue[ left_or_right+"Value" ] > sliderValue.maxValue )
      sliderValue[ left_or_right+"Value" ] = sliderValue.maxValue;

    if( left_or_right == "left" )
      if( sliderValue.leftValue > sliderValue.rightValue )
        sliderValue.leftValue = sliderValue.rightValue;

    if( left_or_right == "right" )
      if( sliderValue.rightValue < sliderValue.leftValue )
        sliderValue.rightValue = sliderValue.leftValue;
  }

  function computePosToValue( position ){
    return (position-MARGIN)/(styleParam.width-MARGIN*2)*(sliderValue.maxValue-sliderValue.minValue)+sliderValue.minValue;
  }



  function defineFunctions(slider){

    slider.setSliderValue = function( minValue, maxValue, leftValue, rightValue ){
      sliderValue = {
        minValue:   minValue,
        maxValue:   maxValue,
        leftValue:    leftValue,
        rightValue:   rightValue
      };
      
      element.select(".minValue")
        .text(convertValueToDate(minValue));
      
      element.select(".maxValue")
        .text(convertValueToDate(maxValue));

      showHandleValue();

      element.select(".leftHandle")
        .style("left", getHandlePosition( "left" )+"px");

      element.select(".rightHandle")
        .style("left", getHandlePosition( "right" )+"px");
    };

    slider.getLeftHandleValue = function(){
      return sliderValue.leftValue;
    };

    slider.getRightHandleValue = function(){
      return sliderValue.rightValue;
    };

    slider.addDraggingFunction = function( f ){
      return draggingFunctions.push( f );
    };

    slider.addDragEndFunction = function( f ){
      return dragEndFunctions.push( f );
    };
  }
}