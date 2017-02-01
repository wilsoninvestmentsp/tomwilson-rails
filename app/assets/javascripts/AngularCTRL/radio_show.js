App.controller('RadioShowCtrl',['$scope','$interval','$upload','$routeParams','$http','$uibModal',function($scope,$interval,$upload,$routeParams,$http,$uibModal){
  var scope = $scope;
  scope.nextPage = ''
  scope.videos = [];
  scope.moment = moment;

  scope.getVideos = function(){
    var path = '/youtube.json?page='+scope.nextPage;
    $http({
      method: 'GET',
      url: path
    }).then(function successCallback(response){
      scope.videos = scope.videos.concat(response.data.items);
      scope.nextPage = response.data.nextPageToken;
    },function errorCallback(response){});
  }
  scope.getVideos();

  scope.getVideo = function(index){
    var video = scope.videos[index];
    video.loading = true;

    $http({
      method: 'GET',
      url: '/youtube/'+video.id.videoId+'.json'
    }).then(function successCallback(response){
      video.snippet.description = response.data.items[0].snippet.description;
      delete video.loading;
      video.more = true;
    },function errorCallback(response){
      delete video.loading;
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