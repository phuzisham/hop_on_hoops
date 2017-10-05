function initMap() {
  var uluru = {lat: 45.5231, lng: -122.6765};
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 13,
    center: uluru
  });
  var geocoder = new google.maps.Geocoder();
  document.getElementById('submit').addEventListener('click', function() {
  geocodeAddress(geocoder, map);
  });
}

function geocodeAddress(geocoder, resultsMap) {
  var address = document.getElementById('address').value;
  geocoder.geocode({'address': address}, function(results, status) {
    if (status === 'OK') {
      resultsMap.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
        map: resultsMap,
        position: results[0].geometry.location
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}
function initAutocomplete() {
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 45.5231, lng: -122.6765},
    zoom: 15,
    mapTypeId: 'roadmap'
  });

  // Create the search box and link it to the UI element.
  var input = document.getElementById('pac-input');
  var searchBox = new google.maps.places.SearchBox(input);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

  // Bias the SearchBox results towards current map's viewport.
  map.addListener('bounds_changed', function() {
    searchBox.setBounds(map.getBounds());
  });

  var markers = [];
  // Listen for the event fired when the user selects a prediction and retrieve
  // more details for that place.
  searchBox.addListener('places_changed', function() {
    var places = searchBox.getPlaces();

    if (places.length == 0) {
      return;
    }

    // Clear out the old markers.
    markers.forEach(function(marker) {
      marker.setMap(null);
    });
    markers = [];

    // For each place, get the icon, name and location.
    var bounds = new google.maps.LatLngBounds();
    places.forEach(function(place) {
      if (!place.geometry) {
        console.log("Returned place contains no geometry");
        return;
      }
      var icon = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };
      // Create a marker for each place.
      markers.push(new google.maps.Marker({
        map: map,
        icon: icon,
        title: place.name,
        position: place.geometry.location
      }));

      if (place.geometry.viewport) {
        // Only geocodes have viewport.
        bounds.union(place.geometry.viewport);
      } else {
        bounds.extend(place.geometry.location);
      }
    });
    map.fitBounds(bounds);
  });
}


      //weather api

$(document).ready(function(){

  var api = "http://api.openweathermap.org/data/2.5/weather?id=5746545&appid=adec1ce255d4ff8e967c9a2d09c5fca1";

  $.getJSON(api, function(data){
  var fTemp;
  var cTemp;
  var kTemp;
  var weatherType;
  var tempSwap = true;

  var weatherType = data.weather[0].description;
  var kTemp = data.main.temp;
  var windspeed = data.wind.speed;
  var city= data.name;

  weatherType= ("Climate: ") + weatherType;

  fTemp= (kTemp*(9/5)-459.67).toFixed(1)
  cTemp= (kTemp-273).toFixed(1)

  windspeed= ("Wind: ") + (2.237*(windspeed)).toFixed(2) + (" mph")
  $("#windspeed").html(windspeed);

  if(parseInt(fTemp) >= 80){
    $("#circle").css('background-image', 'url("/img/sunny.png")');
    }

  else if(parseInt(fTemp) >= 70){
    $("#circle").css('background-image', 'url("/img/mostlycloudy.png")');
    }

  else if(parseInt(fTemp) >= 50){
    $("#circle").css('background-image', 'url("/img/haze.png")');
    }

  else if(parseInt(fTemp) >= 40){
    $("#circle").css('background-image', 'url("/img/snow.png")');
    }

    fTemp = ("Temp: ") + fTemp + (" °F")
    cTemp = ("Temp: ") + cTemp + (" °C")
    $("#city").html(city);
    $("#weatherType").html(weatherType);
    $("#fTemp").html(fTemp);

    $("#fTemp").click(function(){
      if(tempSwap === false){
        $("#fTemp").html(fTemp);
        tempSwap = true;
      }
      else{
        $("#fTemp").html(cTemp);
        tempSwap = false;
      }
    })
  });
});
