App.controller('PropertyCtrl',['$scope','$http',function($scope,$http){
  var scope = $scope;
  scope.charts = [];
  scope.mapped = [];
  scope.newChart = {};
  scope.rawData = {};
  scope.myChartObject = {};
  scope.myChartObject.type = 'PieChart';

  scope.setChart = function(data){
    scope.mapped = data.chart.map(function(item){
      return {c: [
        {v: item.title+':\n$'+item.raw_value},
        {v: parseInt(item.value),f: '$'+item.raw_value}
        ]}
      });

    $scope.myChartObject.data = {"cols": [
    {id: "t", label: "Title", type: "string"},
    {id: "c", label: "Cost", type: "number"}
    ], "rows": scope.mapped };

    scope.myChartObject.options = {
      title: 'Monthly Estimated Income & Expenses\nRent: $'+data.rent,
      pieSliceText: 'value',
      is3D: true,
      backgroundColor: '#f5f5f5',
      chartArea: {top:40,width:'100%',height:'100%'},
      height: '280'
    };	
  };

  scope.createChart = function(chart){
    if (!chart.title || !chart.value){ return; }
    scope.saving = {newChart: true};

    $http({
      method: 'POST',
      url: '/api/v1/charts.json',
      data: {chart: chart}
    }).then(function successCallback(response){
      scope.charts.push(response.data.chart);
      scope.setChart();
      scope.newChart = {property_id: chart.property_id};
      delete scope.saving;
    },function errorCallback(response){delete scope.saving;});
  };

  scope.deleteChart = function(chart,i){
    scope.saving = {};
    scope.saving[chart.id] = '...';

    $http({
      method: 'DELETE',
      url: '/api/v1/charts/'+chart.id+'.json'
    }).then(function successCallback(response){
      scope.charts.splice(i,1);
      scope.setChart();
      delete scope.saving;
    }, function errorCallback(response){delete scope.saving;});
  };
}]);