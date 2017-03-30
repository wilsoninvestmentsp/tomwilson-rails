TomWilson.Events = {
  loadMoreEvents: function(){
    $('#load_more_events').on('click', function(){
      if($('#next_page').val()){
        $.ajax({
          url: '/more_events',
          data: {offset: $('#next_page').val()},
          dataType: 'script'
        });
      }
    });
  },
  documentOnReady: function(){
    this.loadMoreEvents();
  },
  pageLoad: function () {
    TomWilson.Events.documentOnReady();
  }
}
$(document).ready(function(){
  TomWilson.Events.documentOnReady();
});
$(document).on('page:load', function(){
  TomWilson.Events.pageLoad();
});
$(window).on('load page:load',function(){
  $('img').unveil();
});