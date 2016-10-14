App.controller('PropertiesCtrl',['$scope','$http',function($scope,$http){

	var scope = $scope;
	scope.properties = [];
	scope.params = toParams(window.location.search);
	scope.meta = {};
	scope.building_types = {
		// 'single_family': {
		// 	label: 'Single Family',
		// 	value: 'single_family'
		// },
		// 'duplex': {
		// 	label: 'Duplex',
		// 	value: 'duplex'
		// },
		// 'fourplex': {
		// 	label: 'Fourplex',
		// 	value: 'fourplex'
		// },
		// 'multifamily': {
		// 	label: 'Multifamily',
		// 	value: 'multifamily'
		// },
		// 'commercial': {
		// 	label: 'Commercial',
		// 	value: 'commercial'
		// },
		'single_family%2Cduplex%2Cfourplex': {
			label: 'Rental Homes & 2-4\'s',
			value: 'single_family%2Cduplex%2Cfourplex'
		},
		'multifamily%2Ccommercial': {
			label: 'Multifamily & Commercial',
			value: 'multifamily%2Ccommercial'
		}
	}

	scope.getProperties = function(){

		scope.loading = true;

		delete scope.params.q;

		angular.forEach(scope.params,function(val,key){

			if (!val){ delete scope.params[key]; }

		});

		var url = '/api/v1/properties.json'+paramsString(scope.params);

		$http({
		  method: 'GET',
		  url: url
		}).then(function successCallback(response){

			scope.properties = response.data.properties;
			scope.meta = response.data.meta;
			delete scope.loading;

		}, function errorCallback(response){

			JP('PropertiesCtrl getProperties Error!');
			JP(response);
			delete scope.loading;

		});

	}
	scope.getProperties();

	scope.toPage = function(page){

		scope.params.page = page;
		scope.getProperties();

	}

	scope.createArray = function(i){
	    return new Array(i);
	}

}]);

function toParams(string){

	var s = string.replace('?','');
	var a = s.split('&');

	var params = {};

	angular.forEach(a,function(val,key){

		var d = val.split('=');
		params[d[0]] = d[1];

	});

	return params;

}
function paramsString(params){

	var s = '';

	var i = 0;
	angular.forEach(params,function(val,key){

		if (i == 0){s = '?';} else {s += '&';}
		s += key+'='+val;
		i++;

	});

	return s;

}