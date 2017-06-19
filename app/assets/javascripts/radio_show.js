RadioShow = {
  loadMoreRadioShow: function(){
    $('#load_more_radio_show').on('click', function(){
      if($('#next_page_token').val()){
        $.ajax({
          url: '/youtube',
          data: {page: $('#next_page_token').val()},
          dataType: 'script'
        });
      }
    });
  },
  loadMoreDescription: function(){
    $('.load_more_description').on('click', function(){
      var id = $(this).attr('value');
      var selector = '#description_'+id
      $.ajax({
        url: '/youtube/'+id+'.json',
        success: function(response){
          $(selector).text(response.items[0].snippet.description);
          $(selector).next('a:contains("More")').remove();
          $(selector).next('span:contains("|")').remove();
        }
      });
    });
  },
  playVideo: function(){
    $('#radio-show-listing').on('click', '.play_video_now', function(){
      var videoId = $(this).attr('value');
      $.ajax({
        url: '/play_video/'+videoId
      });
    });
  },
  stopVideo: function(){
    $('#play_youtube_video').on('hidden.bs.modal', function(){
      $(this).html('');
    });
  },
  documentOnReady: function(){
    this.loadMoreRadioShow();
    this.loadMoreDescription();
    this.playVideo();
    this.stopVideo();
  },
  pageLoad: function () {
    RadioShow.documentOnReady();
  }
}
$(document).ready(function(){
  RadioShow.documentOnReady();
});
$(document).on('page:load', function(){
  RadioShow.pageLoad();
});
$(window).on('load page:load',function(){
  $('img').unveil();
});