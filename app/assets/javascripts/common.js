TomWilson = {};
TomWilson.Common = {
  bindToolTip: function(){
    $('[data-toggle="tooltip"]').tooltip();
  },
  bindAjaxLoader: function(){
    $(document).ajaxStart(function () {
      applyLoader();
    }).ajaxStop(function () {
      $.unblockUI();
    });
  },
  clickableDiv: function(){
    $('.clickable_div').on('click', function(){
      window.location = $(this).find('a')[1]['href'];
    });
  },
  documentOnReady: function(){
    this.bindToolTip();
    this.bindAjaxLoader();
    this.clickableDiv();
  },
  pageLoad: function () {
    TomWilson.Common.documentOnReady();  
  }
}
$(document).ready(function(){
  TomWilson.Common.documentOnReady();
});
$(document).on('page:load', function(){
  TomWilson.Common.pageLoad();
});