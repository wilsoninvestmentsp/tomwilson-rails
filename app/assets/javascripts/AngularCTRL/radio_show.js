App.controller('RadioShowCtrl',['$scope','$interval','$upload','$routeParams','$http','$uibModal',function($scope,$interval,$upload,$routeParams,$http,$uibModal){
  var scope = $scope;

  scope.getVideo = function(id){
    $http({
      method: 'GET',
      url: '/youtube/'+id+'.json'
    }).then(function successCallback(response){
      $('#description_'+id).text(response.data.items[0].snippet.description);
      $('#description_'+id).next('a').remove();
    },function errorCallback(response){
      JP('Error!');
      JP(response);
    });
  }
  
  scope.openVideo = function(videoId){
    var modalInstance = $uibModal.open({
      animation: $scope.animationsEnabled,
      templateUrl: '/angular?page=youtube&videoId='+videoId,
      controller: 'VideoCtrl',
      size: 'lg'
    });
  }
}]);

App.controller('VideoCtrl',['$scope','$interval','$upload','$routeParams','$http',function($scope,$interval,$upload,$routeParams,$http){
  var scope = $scope;
}]);

$(document).on('ready page:load', function(){
  $('#load_more_radio_show').on('click', function(){
    if($('#next_page_token').val()){
      $.ajax({
        url: '/youtube',
        data: {page: $('#next_page_token').val()},
        dataType: 'script'
      });
    }
  });
});