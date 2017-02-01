App.controller('EventsCtrl',['$scope','$interval','$upload','$routeParams','$http','$uibModal',function($scope,$interval,$upload,$routeParams,$http,$uibModal){
  var scope = $scope;
  scope.events = [];
  scope.moment = moment;

  scope.getEvents = function(){
    scope.loading = true;
    $http({
      method: 'GET',
      url: '/api/v1/meetup.json'
    }).then(function successCallback(response){
      scope.events = response.data;
      delete scope.loading;
    },function errorCallback(response){
      delete scope.loading;
    });
  }
  scope.getEvents();
}]);