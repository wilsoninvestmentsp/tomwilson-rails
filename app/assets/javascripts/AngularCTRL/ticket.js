App.controller('TicketCtrl',['$scope','$interval','$upload','$routeParams','$http','$uibModal',function($scope,$interval,$upload,$routeParams,$http,$uibModal){
	JP('Ticket');
	var scope = $scope;
	scope.show_form = true;
	scope.inquiry = {};
  window.onload = function(e) {
    $("#property-contact").find(':checkbox').trigger('click');
    $("#contact-form").find(':checkbox').trigger('click');
    $("#home-contact").find(':checkbox').trigger('click');
    $(".main_contact").find("option").eq(0).attr('label','Please Select Option').val('Please Select Option').text('Please Select Option')
  };
  scope.inquiry.hear_from_options = ['Where did you hear from us?', "Web Search", "Event", "Print Media",'Radio Show','Referral','Loopnet','Bigger Pockets','Social Media'];
  scope.inquiry.hear_from = scope.inquiry.hear_from_options[0];
	scope.moment = moment;
	scope.submitForm = function(){

		scope.loading = true;

		$http({
			url: '/api/v1/zendesk/ticket.json',
			method: 'POST',
			data: { inquiry: scope.inquiry }
		})
		.then(function(response) {
			scope.inquiry = null;
			$('#home-contact').modal('hide');
			$('#paradise-home-contact').modal('hide');
			$('#inquiry-form').hide();
			//scope.openPopup('success', 'Thank You! Your ticket was successfully submitted!');

			//delete scope.show_form;
			scope.inquiry = {};
			scope.inquiry.hear_from_options = ['Where did you hear from us?', "Web Search", "Event", "Print Media",'Radio Show','Referral','Loopnet','Bigger Pockets','Social Media'];
  		scope.inquiry.hear_from = scope.inquiry.hear_from_options[0];
			delete scope.loading;
			window.location = "/thank-you"

		},
		function(response){
			$('#home-contact').modal('hide');
			$('#paradise-home-contact').modal('hide');
			scope.openPopup('danger', 'Something Went Wrong!');
			delete scope.loading;
			scope.submitForm = null;

		});

	};
	scope.openPopup = function(type,message){
		var modalInstance = $uibModal.open({
			animation: $scope.animationsEnabled,
			templateUrl: '/angular?page=newsletter&type='+type+'&message='+message,
			controller: 'VideoCtrl',
			size: 'lg'
		});
	}

}]);