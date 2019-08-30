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
  clickableEvent: function(){
    $('#event-listing').on('click', '.event_list', function(){
      window.open($(this).children('#event_url').val(), '_blank');
    });
  },
  documentOnReady: function(){
    $('.pagination').css('display', 'block');
    this.loadMoreEvents();
    this.clickableEvent();
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