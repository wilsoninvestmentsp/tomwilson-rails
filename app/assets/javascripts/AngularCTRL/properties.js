App.controller('PropertiesCtrl',['$scope','$http',function($scope,$http){

	var scope = $scope;
	scope.properties = [];
	scope.params = toParams(window.location.search);
	scope.meta = {};
	scope.separate_building_types = {
		'all': {
			label: 'All',
			value: 'single_family%2Cduplex%2Cfourplex%2Cmultifamily%2Ccommercial'
		},
		'single_family': {
			label: 'Single Family',
			value: 'single_family'
		},
		'duplex_fourplex': {
			label: 'Duplex - Fourplex',
			value: 'duplex%2Cfourplex'
		},
		'multifamily': {
			label: 'Multifamily',
			value: 'multifamily'
		},
		'commercial': {
			label: 'Commercial',
			value: 'commercial'
		}
	};
	scope.building_types = {
		'single_family%2Cduplex%2Cfourplex': {
			label: 'Rental Homes & 2-4\'s',
			value: 'single_family%2Cduplex%2Cfourplex'
		},
		'multifamily%2Ccommercial': {
			label: 'Multifamily & Commercial',
			value: 'multifamily%2Ccommercial'
		}
	};
	scope.sort_offer_price = {
		'asc': {
			label: 'Low to High',
			value: 'acs'
		},
		'desc': {
			label: 'High to Low',
			value: 'desc'
		}
	};

	scope.activeMenu = scope.separate_building_types['all'];

	scope.setActive = function(building_type) {
    scope.activeMenu = building_type;
 };

	scope.getStatusClass = function(status){
		switch(status) {
			case 'sold':
				status_class = 'status-tag-top red';
				break;
			case 'for_sale':
				status_class = 'status-tag-top green';
				break;
			case 'sale_pending':
				status_class = 'status-tag-top orange';
				break;
			case 'comming_soon':
				status_class = 'status-tag-top skyblue';
				break;
			case 'reserved':
				status_class = 'status-tag-top yellow';
				break;
			default:
				status_class = 'status-tag-top green';
		}
		return status_class;
	};

	scope.getProperties = function(){

		scope.loading = true;

		delete scope.params.q;
		delete scope.params.page;

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

	scope.getCities = function(){
		delete scope.params.city;
		if(scope.params.state){
			var url = 'properties/get_cities?state='+scope.params.state;
			$.ajax({
      	url: url
      });
		}
		else{
			$('#cities').val('');
			$('#cities').prop('disabled', true);
			$('#cities').selectpicker('refresh');
		}
		scope.getProperties();
	},

	scope.getPropertiesbyCities = function(city){
		scope.params.city = city;
		scope.getProperties();
	},

	scope.getProperties();

	scope.filterPropertiesByBuildingType = function(query){
		scope.loading = true
		delete scope.params.q;
		delete scope.params.page;

		scope.params['building_type'] = query.value
		var url = '/api/v1/properties.json'+paramsString(scope.params);
		scope.getfilteredProperties(url);
	}


	scope.getfilteredProperties = function (url){
		$http({
			method: 'GET',
			url: url
		}).then(function successCallback(response){
			scope.properties = response.data.properties;
			scope.meta = response.data.meta;
			delete scope.loading;
		}, function errorCallback(response){
			delete scope.loading;
		});
	},


	scope.toPage = function(page){

		scope.params.page = page;

		var url = '/api/v1/properties.json'+paramsString(scope.params);

		$http({
			method: 'GET',
			url: url
		}).then(function successCallback(response){
				$.each(response.data.properties, function(i, item) {
      	  scope.properties.push(item);
    		});
				scope.meta = response.data.meta;
		});
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