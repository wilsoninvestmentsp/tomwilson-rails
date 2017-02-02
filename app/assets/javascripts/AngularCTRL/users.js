App.controller('UsersCtrl',['$scope','$http',function($scope,$http){
  var scope = $scope;
  scope.users = [];
  scope.teams = {};
  scope.changed = false;

  scope.setTeams = function(){
    scope.teams = {};
    angular.forEach(scope.users,function(val,key){
      if (scope.teams[val.team]){
        scope.teams[val.team].users.push(val);
      } else {
        scope.teams[val.team] = {name: val.team,users: [val]};
      }
    });
  };

  scope.moveUser = function(user,old_index,new_index){
    if (new_index < 0 || new_index > (scope.users.length-1)){ return false; }
    scope.changed = true;
    scope.users.move(old_index,new_index);
    angular.forEach(scope.users,function(user,i){
      user.sort = i;
    });
  }

  scope.saveOrder = function(){
    scope.loading = true;
    var users = scope.users.map(function(user){
      return user.id;
    });

    $http({
      method: 'PUT',
      url: '/api/v1/users/order.json',
      data: { users: users }
    }).then(function successCallback(response){
      scope.mode = {};
      scope.changed = false;
      delete scope.loading;
    },function errorCallback(response){
      delete scope.loading;
    });
  }

  scope.toUpperCase = function(string){
    return string.charAt(0).toUpperCase() + string.slice(1);
  }
}]);