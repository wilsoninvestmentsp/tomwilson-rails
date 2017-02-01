App.controller('UserFormCtrl',['$scope','$interval','$upload','$routeParams','$http','$uibModal',function($scope,$interval,$upload,$routeParams,$http,$uibModal){
  var scope = $scope;
  scope.events = [];
  scope.moment = moment;
  
  scope.adminChanged = function(){
    if (scope.admin){
      delete scope.password;
    } else {
      scope.password = 'sfksjdfldsflsk';
    }
  }
}]);