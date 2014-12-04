
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
  appendArea("loadingArea");
  $.ajax({
    url: "wines/new",
    dataType: "html",
    cache: false,
    success: function(data, textStatus){
      hiddenArea("loadingArea");
      $("#"+domId).html(data);

      $(function($){
        $("#new_wine")
        .bind("ajax:before", function(){
          appendArea("loadingArea");
        });

        $("#new_wine")
        .bind("ajax:success", function(status, data){
          hiddenArea("loadingArea");
          var result = JSON.parse(data);

          if( "error" in result ){
            showValidationMessage( result.error );
          }else{
            dropPin( result );

            hiddenArea("createWineArea");
          }
        });
        
        $("#new_wine")
        .bind("ajax:error", function(status, data){
          hiddenArea("loadingArea");
          showValidationMessage( {error: ["通信に失敗しました"] } );
        });
      });
      
      $("#createWineArea").click(function(e){
        var target = e.target;
        if (target.id === 'createWineArea') {
          hiddenArea("createWineArea");
      
          d3.select("#createWineForm")
            .select(".main")
            .remove();

          return false;
        }
      });
    },
    error: function(xhr, textStatus, errorThrown){
      hiddenArea("loadingArea");
    }
  });
}

function showValidationMessage( messageJson ){
  var massageHtml="";
  var massageDiv = d3.select(".errorArea");

  massageDiv.selectAll("div").remove();

  for( var key in messageJson ){
    massageDiv.append("div")
              .text(messageJson[key][0]);
  }
}

function dropPin( result ) {
  wineData = result.wine;
  wineData.regions = result.regions;

  var wine = new Wine( wineData );
  wines.push( wine );

  setMarker( googleMap, wine );
      
  d3.select("#new_wine").remove();

  /* jsで緯度経度を取得したくなったら使う

  var geocoder = new google.maps.Geocoder();

  var address = d3.select("#wine_input_region").node().value;

  geocoder.geocode( { 'address': address}, function(results, status) {

    if (status == google.maps.GeocoderStatus.OK) {
      var latlng = results[0].geometry.location;


    // ジオコーディングが成功しなかった場合
    } else {
      console.log('Geocode was not successful for the following reason: ' + status);
          d3.select("#new_wine").remove();
    }
    
  });

  */

}

function switchVisUserMenu(){
  var menuSwitch = d3.select("#userName").property("checked");
  
  if( menuSwitch ){
    d3.select("#userMenu")
      .transition()
      .style("height","60px");
  }else{
    d3.select("#userMenu")
      .transition()
      .style("height","0px");
  }
}






function TwoHandleSlider( d3Element, sliderId ){

  var styleParam = {
    width:      300,
    height:     50
  };

  if(sliderId == "scoreSlider")
    styleParam.width = 200;



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

  var HANDLE_SIZE = 30;
  var BORDER_WEIGHT = 2;
  var MARGIN = 50;
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