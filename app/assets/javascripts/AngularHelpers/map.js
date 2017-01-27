App.directive('googleMap',function(){
    return {

        restrict: 'E',
        templateUrl: '/angular?page=map',
        scope: {
            address: '=address',
            zoom: '=zoom'
        },
        // replace: true,
        link: function(scope,element,attrs){

            scope.map_loading = true;

            var el = element[0].querySelector('.map');

            // function initMap() {
              var address = scope.address;
              geocoder = new google.maps.Geocoder();
              var latlng = new google.maps.LatLng(-34.397, 150.644);
              var myOptions = {
                zoom: scope.zoom,
                center: latlng,
                mapTypeControl: true,
                mapTypeControlOptions: {
                  style: google.maps.MapTypeControlStyle.DROPDOWN_MENU
                },
                navigationControl: true,
                mapTypeId: google.maps.MapTypeId.ROADMAP
              };
              map = new google.maps.Map(el, myOptions);
              if (geocoder) {
                geocoder.geocode({
                  'address': address
                }, function(results, status) {
                  if (status == google.maps.GeocoderStatus.OK) {
                    if (status != google.maps.GeocoderStatus.ZERO_RESULTS) {
                      map.setCenter(results[0].geometry.location);

                      var infowindow = new google.maps.InfoWindow({
                        content: '<b>' + address + '</b>',
                        size: new google.maps.Size(150, 50)
                      });

                      var marker = new google.maps.Marker({
                        position: results[0].geometry.location,
                        map: map,
                        title: address
                      });
                      google.maps.event.addListener(marker, 'click', function() {
                        infowindow.open(map, marker);
                      });

                    } else {
                      alert("No results found");
                    }
                  } else {
                    if($('#is_admin').val() == 'true'){
                      alert("Incorrect address. Enter correct address to generate google map.");
                      $('#google_map').remove();
                    }
                    if($.trim($('.map-graph-section .container').text()) == ''){
                      $('.map-graph-section').remove();
                    }
                    else{
                      $('#google_map').remove();
                    }
                  }
                  delete scope.map_loading;
                });
              } else {
                delete scope.map_loading;
              }
            // }
    
        }

    }
});