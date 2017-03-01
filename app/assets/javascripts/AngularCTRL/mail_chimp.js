App.controller('MailChimpCtrl',['$scope','$interval','$upload','$routeParams','$http','$uibModal',function($scope,$interval,$upload,$routeParams,$http,$uibModal){
  var scope = $scope;
  scope.events = [];
  scope.signup = {investor_source: 'Website'};

  scope.submitForm = function(){
    if(scope.signup_form.$valid){
      scope.loading = true;
      $http({
        url: '/api/v1/mailchimp/signup.json',
        method: 'POST',
        data: { signup: scope.signup }
      })
      .then(function(response){
        scope.openPopup('success', 'Thank you for your interest in our newsletter');
        delete scope.signup;
        delete scope.loading;
      }, 
      function(response){
        scope.openPopup('danger', 'Something Went Wrong!');
        delete scope.loading;
      });
    }else{
      scope.openPopup('danger', 'Please fill in all fields.');
    }
  }

  scope.openPopup = function(type,message){
    var modalInstance = $uibModal.open({
      animation: $scope.animationsEnabled,
      templateUrl: '/angular?page=newsletter&type='+type+'&message='+message,
      controller: 'VideoCtrl',
      size: 'lg'
    });
  }
}]);

App.controller('MailChimpPopupCtrl',['$scope','$interval','$upload','$routeParams','$http',function($scope,$interval,$upload,$routeParams,$http){
  var scope = $scope;
}]);