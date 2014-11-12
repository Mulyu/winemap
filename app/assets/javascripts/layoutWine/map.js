
function setGoogleMap(domId){
  google.load("maps", "3.x", {"other_params":"sensor=false"});

  function initialize() {
    var myLatLng = new google.maps.LatLng(35.47381, 139.59031); // 東京を中心にする

    var myOptions = {
      zoom: 2,
      minZoom: 2,
      maxZoom: 10,
      center: myLatLng,
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      mapTypeControl: false,
      streetViewControl: true,
      scaleControl: false,
      zoomControl: true,
      panControl: false
    };
    
    googleMap = new google.maps.Map(document.getElementById(domId), myOptions);

    applyStyleToGoogleMap(googleMap);
  
    wines.forEach(function(wine){
      setMarker(
        googleMap,
        wine
        );
    });
  }

  google.setOnLoadCallback(initialize);
}

function setMarker(map, wine){
  var myLatlng = new google.maps.LatLng(
    wine.productionDistrict.latitude,
    wine.productionDistrict.longitude );

  wine.marker = new google.maps.Marker({
    position: myLatlng,
    map: map,
    icon: wine.getIconImagePath(),
    animation: google.maps.Animation.DROP,
    title: wine.name
  });

  google.maps.event.addListener(wine.marker, "click", function() {
    wine.setInfoToDetailArea();
    appendArea("detailArea", 0.7);
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

