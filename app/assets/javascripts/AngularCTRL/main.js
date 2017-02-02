App.controller('MainCtrl',['$scope','$http','$interval',function($scope,$http,$interval){
  var scope = $scope;
  scope.params = toParams(window.location.search);
  scope.container = {};

  scope.setBackground = function(){
  // angular.forEach(images,function(val,key){
  // 	var i = Math.floor(Math.random() * (images.length-1)) + 0
  // 	scope.newImages.push(images[i]);
  // 	images.splice(i,1);
  // });
  // scope.setRotation();
  };
  // scope.setBackground();

  scope.searchProperties = function(q){
    if (!q){return;}
    scope.container.loading = true;
    var url = '/api/v1/properties.json?address=|*'+q+'*&title=|*'+q+'*&city=|*'+q+'*&state=|*'+q+'*';

    $http({
      method: 'GET',
      url: url
    }).then(function successCallback(response){
      scope.container.properties = response.data.properties;
      scope.container.meta = response.data.meta;
      delete scope.container.loading;
    }, function errorCallback(response){
      delete scope.container.loading;
    });
  }

  if (scope.params.q){ scope.searchProperties(scope.params.q); }
  scope.searchChanged = function(q){
    scope.container.loading = true;
    if (!q){ delete scope.container.properties; }
  }

  Turbolinks.enableProgressBar(true);

  setTimeout(function(){
    $('.flash-message-container').slideUp(300);
  },4000);
}]);