App.controller('FeaturedCtrl',['$scope','$http',function($scope,$http){

	JP('FeaturedCtrl');

	var scope = $scope;
	scope.mode = {};
	scope.properties = [];
	scope.changed = false;

	scope.getStatusClass = function(status){
		switch(status) {
			case 'for_sale':
				status_class = 'status-tag green';
				break;
			case 'reserved':
				status_class = 'status-tag yellow';
				break;
			default:
				status_class = 'status-tag-top yellow';
		}
		return status_class;
	};

	scope.moveProperty = function(property,old_index,new_index){

		if (new_index < 0 || new_index > (scope.properties.length-1)){ return false; }

		scope.properties.move(old_index,new_index);
		scope.changed = true;
		angular.forEach(scope.properties,function(property,i){

			property.featured = i;

		});

	}

	scope.saveOrder = function(){

		scope.loading = true;

		var properties = scope.properties.map(function(property){

			return property.id;

		});

		$http({
		  method: 'PUT',
		  url: '/api/v1/properties/order.json',
		  data: { properties: properties }
		}).then(function successCallback(response){

			JP(response);
			scope.mode = {};
			scope.changed = false;
			delete scope.loading;

		}, function errorCallback(response){

			JP('Error!');
			JP(response);
			delete scope.loading;

		});

	}

}]);