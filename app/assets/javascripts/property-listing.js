PropertyListing = {
  propertyFilter: function(){
    $("#price-filter").slider({tooltip:'always', id: "price-filter"}).on('slideStop', function(ev){
      angular.element('#PropertiesCtrl').scope().getProperties();
    });
  },
  documentOnReady: function(){
    $('[data-toggle="tooltip"]').tooltip();
    this.propertyFilter();
  }
}
$(document).ready(function(){
  PropertyListing.documentOnReady();
});