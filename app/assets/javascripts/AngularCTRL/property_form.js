// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// APPLICATION !!!!!!! APPLICATION !!!!!!! APPLICATION !!!!!!! APPLICATION !!!!!!! APPLICATION !!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
App.controller('PropertyFormCtrl',['$scope','$interval','$upload','$routeParams','$http',
	function($scope,$interval,$upload,$routeParams,$http){
			
		JP('PROP');

		var scope = $scope;

		scope.params = $routeParams;

		scope.myInterval = 5000;
		scope.noWrapSlides = false;
		scope.active = 0;
		scope.property = {};
		var slides = scope.slides = [];
		var currIndex = 0;
		scope.images = [];
		scope.image_ids = [];

		scope.myInterval = 5000;
		scope.noWrapSlides = false;
		scope.active = 0;
		var slides = $scope.slides = [];
		var currIndex = 0;

		
		JP('MAIN');

		scope.updateLink = function(link, i){
			scope.saving = {};
			scope.saving[link.id] = '...';

			if (!link.title && !link.link){
				scope.deleteLink(link, i);
				return;
			}

			if(!link.title){
				alert('Please Enter Link Title')
				delete scope.saving;
				return;
			}

			// var url_regex =  new RegExp("/((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)/");
			// if(!url_regex.test(link.link)){
			// 	alert('Please Enter Valid Link');
			// 	return;
			// }

			$http({
			  method: 'PUT',
			  url: '/api/v1/links/'+link.id+'.json',
			  data: {link: link}
			}).then(function successCallback(response){
				delete scope.saving;
				delete link.edit;
			});
		}
		scope.uploadUrl = function(id,url){

			scope.img_loading = true;

			$http({
				url: '/properties/'+id+'/images',
				method: 'POST',
				data: { url: url }
			})
			.then(function(response) {

				scope.images.push(response.data);
				scope.image_ids.push(response.data.id);

				delete scope.imageUrl;
				delete scope.img_loading;

			}, 
			function(response){
#?&//=]*)/ ");
			
				delete scope.img_loading;

			});

		}

		scope.updateAddressPaste = function(event){

			var address = event.originalEvent.clipboardData.getData('text/plain');
			scope.updateAddress(address);

		}
		scope.updateAddress = function(address){

			if (address && address != ''){} else { return null; }

			var parsed = parseAddress.parseLocation(address);
			
			JP(parsed);
			
			scope.property.address = parsed.number;
			if (parsed.prefix){
				scope.property.address += ' '+parsed.prefix;
			}
			scope.property.address += ' '+parsed.street+' '+parsed.type;
			scope.property.city = parsed.city;
			scope.property.state = parsed.state;
			scope.property.zip = parsed.zip;

		}

				// UPLOADER
				// =====================================================================
				// =====================================================================
				$scope.upload = function(files,id){

					if (files && files.length) {
						scope.upload_pct = 1;
						for (var i = 0; i < files.length; i++) {
							var file = files[i];

							scope.img_loading = true;

							$upload.upload({
								url: '/properties/'+id+'/images',
								file: file,
							}).progress(function (evt) {
								
								var progressPercentage = parseInt(100.0 * evt.loaded / evt.total);
								scope.upload_pct = progressPercentage

							}).success(function (data,status,headers,config) {
								
								scope.images.push(data);
								scope.image_ids.push(data.id);

								delete scope.upload_pct;
								delete scope.img_loading;

							}).error(function(){

								delete scope.upload_pct;
								delete scope.img_loading;

							});
						}
					}

				};
		        // =====================================================================
		        // =====================================================================

		       	scope.removeImage = function(_image){

		       		if (confirm("Remove this image?")){

		       			$http.delete('/images/'+_image.id,null)
		       			.then(
		       				function(response){

		       					angular.forEach(scope.images,function(image,i){

		       						if (image.id == _image.id){

		       							scope.images.splice(i,1);

		       						}

		       					});
		       					angular.forEach(scope.image_ids,function(id,i){

		       						if (id == _image.id){

		       							JP(id);
		       							scope.image_ids.splice(i,1);

		       						}

		       					});

		       				},
		       				function(response){



		       				}
		       			);

		       		}

		       	}

		// Begin createLink =====================================
		scope.createLink = function(link){
			if (!link.title || !link.link){
				alert('Please Enter Link Title and Link');
				return;
			}
			
			// var url_regex =  new RegExp("/([-a-zA-Z0-9:%_\+.~#?&//=]*)/ ");
			// if(!url_regex.test(link.link)){
			// 	alert('Please Enter Valid Link');
			// return;
			// }

			scope.saving = {new: true};

			$http({
			  method: 'POST',
			  url: '/api/v1/links.json',
			  data: {link: link}
			}).then(function successCallback(response){

				JP(response);
				scope.links.push(response.data.link);
				scope.newLink = {property_id: scope.newLink.property_id};
				delete scope.saving;

			}, function errorCallback(response){

				JP('Error!');
				JP(response);
				delete scope.saving;

			});
		
		};
		// End createLink =======================================

		// Begin deleteLink =====================================
		scope.deleteLink = function(link,i){
			
			scope.saving = {};
			scope.saving[link.id] = '...';

			$http({
			  method: 'DELETE',
			  url: '/api/v1/links/'+link.id+'.json'
			}).then(function successCallback(response){

				JP(response);
				scope.links.splice(i,1);
				delete scope.saving;

			}, function errorCallback(response){

				JP('Error!');
				JP(response);
				delete scope.saving;

			});
		
		};
		// End deleteLink =======================================
		
		scope.editLink = function(i){
			scope.links[i].edit = true;
			scope.links[i].old_title = scope.links[i].title;
			scope.links[i].old_link = scope.links[i].link;
		}
		
 		scope.cancelEditing = function(i){
			scope.links[i].edit = false;
			scope.links[i].title = scope.links[i].old_title;
			scope.links[i].link = scope.links[i].old_link;
		}
	}
]);