App.controller('MainCtrl',['$scope','$http','$interval',function($scope,$http,$interval){

	var scope = $scope;
	// scope.params = toParams(window.location.search);
	// scope.container = {};

	// Begin changeBackground =====================================
	// scope.setBackground = function(){

		// angular.forEach(images,function(val,key){

		// 	var i = Math.floor(Math.random() * (images.length-1)) + 0
		// 	scope.newImages.push(images[i]);
		// 	images.splice(i,1);

		// });

		// scope.setRotation();

	// };
	// End changeBackground =======================================
	// scope.setBackground();

	// scope.searchProperties = function(q){

	// 	if (!q){return;}

	// 	scope.container.loading = true;

	// 	var url = '/api/v1/properties.json?address=|*'+q+'*&title=|*'+q+'*&city=|*'+q+'*&state=|*'+q+'*';

	// 	$http({
	// 	  method: 'GET',
	// 	  url: url
	// 	}).then(function successCallback(response){

	// 		scope.container.properties = response.data.properties;
	// 		scope.container.meta = response.data.meta;
	// 		delete scope.container.loading;

	// 	}, function errorCallback(response){

	// 		JP('Main Ctrl searchProperties Error!');
	// 		JP(response);
	// 		delete scope.container.loading;

	// 	});

	// }

	// if (scope.params.q){ scope.searchProperties(scope.params.q); }

	// scope.searchChanged = function(q){

	// 	scope.container.loading = true;

	// 	if (!q){ delete scope.container.properties; }

	// }

// 	function toParams(string){
//  var s = string.replace('?','');
//  var a = s.split('&');
//  var params = {};
//  angular.forEach(a,function(val,key){
//    var d = val.split('=');
//    params[d[0]] = d[1];
//  });
//  return params;
// }

// function paramsString(params){
//  var s = '';
//  var i = 0;
//  angular.forEach(params,function(val,key){
//    if (i == 0){s = '?';} else {s += '&';}
//    s += key+'='+val;
//    i++;
//  });
//  return s;
// }
	Turbolinks.enableProgressBar(true);

	setTimeout(function(){
		$('.flash-message-container').slideUp(300);
	},4000);

}]);