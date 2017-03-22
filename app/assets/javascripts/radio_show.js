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
      $.ajax({
        url: '/youtube/'+id+'.json',
        success: function(response){
          $('#description_'+id).text(response.items[0].snippet.description);
          $('#description_'+id).next('a').remove();
          $('#description_'+id).next('span').remove();
        }
      });
    });
  },
  playVideo: function(){
    $('.play_now_video').on('click', function(){
      var id = $(this).attr('value');
      $.ajax({
        url: 'play_video',
        data: {videoId: id},
        dataType: 'script'
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