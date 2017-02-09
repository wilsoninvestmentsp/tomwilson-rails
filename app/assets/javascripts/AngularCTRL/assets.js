App.controller('AssetsCtrl',['$scope','$http',function($scope,$http){

	var scope = $scope;
	scope.assets = {
		items: [],
		meta: {}
	};
	scope.newAsset = {};
	scope.params = toParams(window.location.search);

	// Begin getAssets =====================================
	scope.getAssets = function(){
		
		scope.assets.meta.loading = true;

		var url = '/api/v1/jassets.json?order=created_at DESC';

		$http({
		  method: 'GET',
		  url: url
		}).then(function successCallback(response){

			JP(response);
			scope.assets.items = response.data.jassets;
			delete scope.assets.meta.loading;
			setTimeout(function(){$('img').unveil();},200);
		}, function errorCallback(response){

			JP(response);
			delete scope.assets.meta.loading;

		});
	
	};
	// End getAssets =======================================
	scope.getAssets();

	scope.sortResourceType = function(){
		delete scope.params.q;
		angular.forEach(scope.params,function(val,key){
			if (!val){ delete scope.params[key]; }
		});
		scope.assets.meta.loading = true;

		if(scope.params.link_name == '' && !scope.params.order_date){
			scope.params.order = 'created_at DESC';
			delete scope.params.link_name;
		}else{ delete scope.params.order }

		if (!scope.params.order_date && !scope.params.link_name){
			scope.params.order = 'created_at DESC';
		}else{ delete scope.params.order }

		var url = '/api/v1/jassets.json'+paramsString(scope.params);
		$http({
		  method: 'GET',
		  url: url
		}).then(function successCallback(response){
			scope.assets.items = response.data.jassets;
			delete scope.assets.meta.loading;
			setTimeout(function(){$('img').unveil();},200)
		},function errorCallback(response){
			delete scope.assets.meta.loading;
		});
	};

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