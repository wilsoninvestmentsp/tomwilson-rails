App.controller('UserFormCtrl',['$scope','$interval','$upload','$routeParams','$http','$uibModal',function($scope,$interval,$upload,$routeParams,$http,$uibModal){
  var scope = $scope;
  scope.events = [];
  scope.moment = moment;
  
  scope.adminChanged = function(){
    if (scope.admin){
      delete scope.password;
    } else {
      scope.password = 'sfksjdfldsflsk';
    }
  }
  scope.removeImage = function(user_id){
    var image_url = '/custom/thumb-blank-profile-image.png'
    if($('.img-thumbnail').attr('src') != image_url){
      if (confirm('Are you sure you want to remove this Image?')){
        $http({
          method: 'PATCH',
          url: '/our-team/'+user_id+'.json',
          data: {user: {remove_image: true}}
        }).then(function successCallback(response){
          $('.img-thumbnail').attr('src', response.data.image.thumb.url);
        },
        function errorCallback(response){});
      }
    }
  }
}]);