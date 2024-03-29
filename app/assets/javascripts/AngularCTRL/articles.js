App.controller('ArticlesCtrl',['$scope','$http',function($scope,$http){

	var scope = $scope;
	scope.articles = [];
	scope.meta = {};

	JP('ArticlesCtrl');

	// Begin getArticles =====================================
	scope.getArticles = function(){
		
		JP('getArticles');

		scope.meta.articles = {loading: true};

		$http({
		  method: 'GET',
		  url: '/api/v1/zendesk/articles.json'
		}).then(function successCallback(response){

			if (response.data.articles){

				scope.articles = response.data.articles.map(function(item){
					
					var article = item;
					article.raw_created_at = moment(article.created_at).format('MMM D, YYYY');

					return article;

				});

			}
			
			delete scope.meta.articles;

		}, function errorCallback(response){

			JP('Error!');
			JP(response);
			delete scope.meta.articles;

		});
	
	};
	// End getArticles =======================================
	scope.getArticles();

}]);