TomWilson = {};
TomWilson.Common = {
  bindToolTip: function(){
    $('[data-toggle="tooltip"]').tooltip();
  },
  applyLoader: function(){
    $.blockUI({message: '<img src="/ring-alt.svg" width="75px" />',
      css: {
        border: 'none',
        padding: '15px',
        backgroundColor: 'transparent',
        '-webkit-border-radius': '10px',
        '-moz-border-radius': '10px',
        opacity: .5,
        color: '#fff',
        'z-index': '9999'
      }
    });
  },
  bindAjaxLoader: function(){
    $(document).ajaxStart(function () {
      TomWilson.Common.applyLoader();
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