
function setGoogleMap(domId){
  google.load("maps", "3.x", {"other_params":"sensor=false"});

  function initialize() {
    var myLatLng = new google.maps.LatLng(35.47381, 139.59031); // 東京を中心にする

    var myOptions = {
      zoom: 2,
      center: myLatLng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    
    googleMap = new google.maps.Map(document.getElementById(domId), myOptions);

    applyStyleToGoogleMap(googleMap);
  
    wines.forEach(function(wine){
      setMarker(
        googleMap,
        wine.name,
        wine.productionDistrict.latitude,
        wine.productionDistrict.longitude
        );
    });

  }

  google.setOnLoadCallback(initialize);
}

function setMarker(map, markarName, latitude, longitude){
  var myLatlng = new google.maps.LatLng(
    latitude,
    longitude );
  var marker = new google.maps.Marker({
    position: myLatlng,
    map: map,
    animation: google.maps.Animation.DROP,
    title: markarName
  });
}

function applyStyleToGoogleMap(map){
  var blackStyle = [
  {
    "featureType": "poi",
    "stylers": [
    { "visibility": "off" }
    ]
  },{
    "featureType": "road",
    "stylers": [
    { "visibility": "off" }
    ]
  },{
    "featureType": "transit",
    "stylers": [
    { "visibility": "off" }
    ]
  },{
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
    { "color": "#555555" }
    ]
  },{
    "featureType": "administrative",
    "elementType": "labels.text.fill",
    "stylers": [
    { "color": "#FFFFFF" }
    ]
  },{
    "featureType": "landscape",
    "stylers": [
    { "color": "#000000" },
    { "visibility": "on" }
    ]
  },{
  },{
  },{
    "featureType": "water",
    "stylers": [
    { "color": "#202020" }
    ]
  },{
  }
  ];

  var blackStyleOptions = {
    name: "blackMap"
  };

  var sampleMapType = new google.maps.StyledMapType(blackStyle, blackStyleOptions);
  map.mapTypes.set('black', sampleMapType);
  map.setMapTypeId('black');
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