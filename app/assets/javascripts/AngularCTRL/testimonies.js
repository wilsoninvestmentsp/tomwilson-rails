App.controller('TestimoniesCtrl',['$scope','$http','$interval',function($scope,$http,$interval){
  var scope = $scope;
  scope.testimonies = [];
  scope.testimonyEdit = {};
  var timer;

  scope.getTestimonies = function(){
    scope.testimonies_loading = true;
    $http({
      method: 'GET',
      url: '/api/v1/testimonies.json?order=sort'
    }).then(function successCallback(response){
      scope.testimonies = response.data.testimonies;
      delete scope.testimonies_loading;
      scope.setRotation();
    },function errorCallback(response){
      delete scope.testimonies_loading;
      scope.setRotation();
    });
  };
  scope.getTestimonies();

  scope.selectedTestimony = 0
  scope.setRotation = function(){
    scope.selectedTestimony = 0
    $interval.cancel(timer);
    timer = $interval(scope.increment,10000);
  };

  scope.increment = function(){
    scope.selectedTestimony++;
    if (scope.selectedTestimony >= scope.testimonies.length){
      scope.selectedTestimony = 0;
    }
  };

  scope.moveTestimony = function(testimony,old_index,new_index){
    if (new_index < 0 || new_index > (scope.testimonies.length-1)){ return false; }
    scope.changed = true;
    scope.testimonies.move(old_index,new_index);
    angular.forEach(scope.testimonies,function(testimony,i){
      testimony.sort = i;
    });
  };

  scope.saveTestimony = function(testimony){
    scope.saving = {};
    scope.saving[testimony.id] = 'Saving...';
    var newTestimony = angular.copy(testimony);
    delete newTestimony.id;
    delete newTestimony.edit;
    delete newTestimony.sort;

    $http({
      method: 'PUT',
      url: '/api/v1/testimonies/'+testimony.id+'.json',
      data: { testimony: newTestimony }
    }).then(function successCallback(response){
      delete scope.saving;
      delete testimony.edit;
    },function errorCallback(response){
      delete scope.saving;
    });
  };

  scope.saveOrder = function(){
    scope.saving = {order: 'Saving...'};
    var testimonies = scope.testimonies.map(function(testimony){
      return testimony.id;
    });

    $http({
      method: 'PUT',
      url: '/api/v1/testimonies/order.json',
      data: { testimonies: testimonies }
    }).then(function successCallback(response){
      delete scope.saving;
    }, function errorCallback(response){
      delete scope.saving;
    });
  };

  scope.createTestimony = function(testimony){
    scope.saving = {new: 'Saving...'};
    $http({
      method: 'POST',
      url: '/api/v1/testimonies.json',
      data: { testimony: testimony }
    }).then(function successCallback(response){
      scope.testimonies.push(response.data.testimony);
      delete scope.newTestimony;
      delete scope.saving;
    },function errorCallback(response){
      delete scope.saving;
    });
  };

  scope.deleteTestimony = function(testimony,i){
    if (!confirm('Are your sure you wish to delete this testimony?\n\n"'+testimony.quote+'"\n- '+testimony.author)){ return; }
    scope.saving = {};
    scope.saving[testimony.id] = 'Deleting...';

    $http({
      method: 'DELETE',
      url: '/api/v1/testimonies/'+testimony.id+'.json',
      data: { testimony: testimony }
    }).then(function successCallback(response){
      scope.testimonies.splice(i,1);
      delete scope.saving;
    },function errorCallback(response){
      delete scope.saving;
    });
  };

  scope.editTestimony = function(i){
    scope.testimonies[i].edit = true;
    scope.testimonies[i].old_quote = scope.testimonies[i].quote;
    scope.testimonies[i].old_author = scope.testimonies[i].author;
  }

  scope.cancelEditing = function(i){
    scope.testimonies[i].edit = false;
    scope.testimonies[i].quote = scope.testimonies[i].old_quote;
    scope.testimonies[i].author = scope.testimonies[i].old_author;
  }
}]);