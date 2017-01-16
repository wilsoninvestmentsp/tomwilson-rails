App.controller('PropertyCtrl',['$scope','$http',function($scope,$http){

	var scope = $scope;
	scope.charts = [];
	scope.mapped = [];
	scope.newChart = {};
	scope.rawData = {};
	
	scope.myChartObject = {};
	scope.myChartObject.type = 'PieChart';

	// Begin setChart =====================================
	scope.setChart = function(data){
		
		scope.mapped = data.chart.map(function(item){

			return {c: [
		            {v: item.title+':\n$'+item.raw_value},
		            {v: parseInt(item.value),f: '$'+item.raw_value}
		        ]}

		});

		JP(scope.mapped);

		$scope.myChartObject.data = {"cols": [
		        {id: "t", label: "Title", type: "string"},
		        {id: "c", label: "Cost", type: "number"}
		    ], "rows": scope.mapped };

		var height = 250;
		var url = window.location.pathname.split('/');
		var action = url[3];
		if(action){
			height = '400';		
		}

		scope.myChartObject.options = {
			title: 'Monthly Estimated Income & Expenses\nRent: $'+data.rent,
			pieSliceText: 'value',
			is3D: true,
			backgroundColor: '#f5f5f5',
			chartArea: {top:40,width:'80%',height:'100%'},
			height: height,
		};
	
	};
	// End setChart =======================================


	// Begin createChart =====================================
	scope.createChart = function(chart){

		if (!chart.title || !chart.value){ return; }
		
		scope.saving = {newChart: true};

		$http({
		  method: 'POST',
		  url: '/api/v1/charts.json',
		  data: {chart: chart}
		}).then(function successCallback(response){

			JP(response);
			scope.charts.push(response.data.chart);
			scope.setChart();
			scope.newChart = {property_id: chart.property_id};
			delete scope.saving;

		}, function errorCallback(response){

			JP('Error!');
			JP(response);
			delete scope.saving;

		});
	
	};
	// End createChart =======================================


	// Begin deleteChart =====================================
	scope.deleteChart = function(chart,i){
		
		scope.saving = {};
		scope.saving[chart.id] = '...';

		$http({
		  method: 'DELETE',
		  url: '/api/v1/charts/'+chart.id+'.json'
		}).then(function successCallback(response){

			JP(response);
			scope.charts.splice(i,1);
			scope.setChart();
			delete scope.saving;

		}, function errorCallback(response){

			JP('Error!');
			JP(response);
			delete scope.saving;

		});
	
	};
	// End deleteChart =======================================

}]);