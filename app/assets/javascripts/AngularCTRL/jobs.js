App.controller('JobsCtrl',['$scope','$http',function($scope,$http){
  var scope = $scope;
  scope.jobs = {};

  scope.syncSpreadsheet = function(){
    scope.jobs.loading = true;
    var url = '/api/v1/jobs/master-spreadsheet.json';

    $http({
      method: 'GET',
      url: url
    }).then(function successCallback(response){
      delete scope.jobs.loading;
      alert(response.data.message);
    }, function errorCallback(response){
      delete scope.jobs.loading;

      if (response.data && response.data.message){
        alert(response.data.message);
      } else {
        alert('An error occured!');
      }
    });
  }
}]);