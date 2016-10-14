App.controller('UserFormCtrl',['$scope','$interval','$upload','$routeParams','$http','$uibModal',function($scope,$interval,$upload,$routeParams,$http,$uibModal){

	JP('User Form');

	var scope = $scope;
	scope.events = [];

	scope.moment = moment;

	scope.adminChanged = function(){

		JP("Changed: "+scope.admin);
		if (scope.admin){

			delete scope.password;

		} else {

			scope.password = 'sfksjdfldsflsk';

		}

	}

}]);