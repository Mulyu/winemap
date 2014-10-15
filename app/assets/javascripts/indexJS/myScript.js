
function setGoogleMap(domId){
  google.load("maps", "3.x", {"other_params":"sensor=false"});

  function initialize() {
    var myLatLng = new google.maps.LatLng(35.47381, 139.59031);

    var myOptions = {
      zoom: 2,
      center: myLatLng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    
    map = new google.maps.Map(document.getElementById(domId), myOptions);

     var samplestyle = [
      {
        featureType: "poi.park",
        elementType: "all",
        stylers: [
          { gamma: 0.4 }
        ]
      },{
        featureType: "water",
        elementType: "all",
        stylers: [
          { hue: "#00ffff" },
          { lightness: 50 }
        ]
      },{
        featureType: "road",
        elementType: "all",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "transit",
        elementType: "all",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "transit",
        elementType: "all",
        stylers: [
          { gamma: 0 },
          { visibility: "off" }
        ]
      }
    ];

    var samplestyleOptions = {
      name: "シンプル"
    };

    wines.forEach(function(wine){
      var myLatlng = new google.maps.LatLng(
                        wine.productionDistrict.longitude,
                        wine.productionDistrict.latitude );
      var marker = new google.maps.Marker({
         position: myLatlng,
         map: map,
         title:wine.name
      });
    });

  }

  google.setOnLoadCallback(initialize);
}


function enableUpdateVisAreaSize(domId){
  var windowSizingTimer = false;
  d3.select("#"+domId)
    .attr("style", "width:"+windowX+"px; height:"+(windowY-140)+"px");

  $(window).resize(function() {
      if (windowSizingTimer !== false) {
          clearTimeout(windowSizingTimer);
      }
      windowSizingTimer = setTimeout(function() {
          windowX=window.innerWidth;
          windowY=window.innerHeight;

          d3.select("#"+domId)
            .attr("style", "width:"+windowX+"px; height:"+(windowY-140)+"px");

      }, 200);
  });
}