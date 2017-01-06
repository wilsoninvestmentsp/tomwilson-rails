PropertyListing = {
  propertyFilter: function(){
    $("#price-filter").slider({tooltip:'always', id: "price-filter"}).on('slideStop', function(ev){
      angular.element('#PropertiesCtrl').scope().getProperties();
    });
    $('#property_id').on('change', function(){
      if($(this).val()!=''){
        angular.element('#PropertiesCtrl').scope().filterPropertiesByCity($(this).val());
        angular.element('#PropertiesCtrl').scope().filterPropertiesByCity($(this).val());
      }
    });
  },
  documentOnReady: function(){
    this.propertyFilter();
  }
}
$(document).ready(function(){
  PropertyListing.documentOnReady();
});