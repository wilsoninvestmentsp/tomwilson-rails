App.controller('AssetsCtrl',['$scope','$http',function($scope,$http){
  var scope = $scope;
  scope.assets = {
    items: [],
    meta: {}
  };
  scope.newAsset = {};

  scope.getAssets = function(){
    scope.assets.meta.loading = true;
    var url = '/api/v1/jassets.json?order=sort DESC';

    $http({
      method: 'GET',
      url: url
    }).then(function successCallback(response){
      scope.assets.items = response.data.jassets;
      delete scope.assets.meta.loading;
    },function errorCallback(response){
      delete scope.assets.meta.loading;
    });
  };

  scope.getAssets();

  scope.getAssetsByType = function(){
    scope.assets.meta.loading = true;

    if($('#order_link_name').val() != ''){
      var url = '/api/v1/jassets.json?order_link_name='+$('#order_link_name').val();
    }else{
      var url = '/api/v1/jassets.json?order=sort DESC';
    }

    $http({
      method: 'GET',
      url: url
    }).then(function successCallback(response){
      scope.assets.items = response.data.jassets;
      delete scope.assets.meta.loading;
    },function errorCallback(response){
      delete scope.assets.meta.loading;
    });
  };

  scope.createAsset = function(){
    if (!scope.newAsset.title || !scope.newAsset.link_name || !scope.newAsset.link_uri){ return; }
    scope.assets.meta.newLoading = true;

    $http({
      method: 'POST',
      url: '/api/v1/jassets.json',
      data: { asset: scope.newAsset }
    }).then(function successCallback(response){
      scope.assets.items.push(response.data.jasset);
      delete scope.newAsset;
      delete scope.assets.meta.newLoading;
    },function errorCallback(response){
      delete scope.assets.meta.newLoading;
    });
  };

  scope.removeAsset = function(asset,i){
    if (!confirm('Are you sure you want to delete '+asset.title+'?')){ return; }
    scope.assets.meta.removeLoading = {};
    scope.assets.meta.removeLoading[asset.id] = true;

    $http({
      method: 'DELETE',
      url: '/api/v1/jassets/'+asset.id+'.json'
    }).then(function successCallback(response){
      scope.assets.items.splice(i,1);
      delete scope.assets.meta.removeLoading;
    },function errorCallback(response){
      delete scope.assets.meta.removeLoading;
    });
  };

  scope.removeImage = function(jasset){
    if(jasset.image.image.url != '/custom/no-image.png'){
      if (confirm('Are you sure you want to remove this Image?')){
        jasset.image = '';
        $http({
          method: 'PATCH',
          url: '/api/v1/jassets/'+jasset.id+'.json',
          data: {jasset: {remove_image: true}}
        }).then(function successCallback(response){},
        function errorCallback(response){});
      }
    }
  }
}]);