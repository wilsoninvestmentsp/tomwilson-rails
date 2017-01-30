App.controller('AssetsCtrl',['$scope','$http',function($scope,$http){

	var scope = $scope;
	scope.assets = {
		items: [],
		meta: {}
	};
	scope.newAsset = {};

	// Begin getAssets =====================================
	scope.getAssets = function(){
		
		scope.assets.meta.loading = true;

		var url = '/api/v1/jassets.json?order=sort DESC';

		$http({
		  method: 'GET',
		  url: url
		}).then(function successCallback(response){

			JP(response);
			scope.assets.items = response.data.jassets;
			delete scope.assets.meta.loading;

		}, function errorCallback(response){

			JP(response);
			delete scope.assets.meta.loading;

		});
	
	};
	// End getAssets =======================================
	scope.getAssets();


	// Begin createAsset =====================================
	scope.createAsset = function(){
		
		JP(1);

		if (!scope.newAsset.title || !scope.newAsset.link_name || !scope.newAsset.link_uri){ return; }

		JP(2);

		scope.assets.meta.newLoading = true;

		$http({
			method: 'POST',
		  	url: '/api/v1/jassets.json',
		  	data: { asset: scope.newAsset }
		}).then(function successCallback(response){

			JP(response);
			scope.assets.items.push(response.data.jasset);
			delete scope.newAsset;
			delete scope.assets.meta.newLoading;

		}, function errorCallback(response){

			JP(response);
			delete scope.assets.meta.newLoading;

		});
	
	};
	// End createAsset =======================================


	// Begin removeAsset =====================================
	scope.removeAsset = function(asset,i){

		if (!confirm('Are you sure you want to delete '+asset.title+'?')){ return; }
		
		scope.assets.meta.removeLoading = {};
		scope.assets.meta.removeLoading[asset.id] = true;

		$http({
			method: 'DELETE',
		  	url: '/api/v1/jassets/'+asset.id+'.json'
		}).then(function successCallback(response){

			JP(response);
			scope.assets.items.splice(i,1);
			delete scope.assets.meta.removeLoading;

		}, function errorCallback(response){

			JP(response);
			delete scope.assets.meta.removeLoading;

		});
	
	};
	// End removeAsset =======================================

	//  Remove Asset Image
	scope.removeImage = function(jasset){
		if(jasset.image.image.url != '/custom/no-image.png'){
			if (confirm("Remove this image?")){
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