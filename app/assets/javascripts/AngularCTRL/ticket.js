App.controller('TicketCtrl',['$scope','$interval','$upload','$routeParams','$http','$uibModal',function($scope,$interval,$upload,$routeParams,$http,$uibModal){
	JP('Ticket');

	var scope = $scope;
	scope.show_form = true;
	scope.inquiry = {};
  window.onload = function(e) {
    $("#property-contact").find(':checkbox').trigger('click');
    $("#contact-form").find(':checkbox').trigger('click');
    $("#home-contact").find(':checkbox').trigger('click');
  };

	scope.alerts = [];

	scope.moment = moment;
	scope.submitForm = function(){

		scope.loading = true;

		$http({
			url: '/api/v1/zendesk/ticket.json',
			method: 'POST',
			data: { inquiry: scope.inquiry }
		})
		.then(function(response) {

			scope.alerts = [];
			scope.alerts.push({
				type: 'success',
				message: 'Thank You! Your ticket was successfully submitted!'
			});
			delete scope.show_form;
			delete scope.loading;

		},
		function(response){

			delete scope.loading;

		});

	};

}]);