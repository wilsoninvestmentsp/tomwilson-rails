Syndication = {
  pagintation: function(){
    if ($('.pagination').length){
      $('#more_syndication').on('click', function(){
        var url = $('.pagination .next').children('a').attr('href');
        if(url){$.getScript(url);return false;}
      });
    }
  },
  databyYear: function(){
    $('#syndication_years').on('change', function(){
      var year = $(this).val();
      $.ajax({
        url: '/track-record/'+$('#slug_id').val(),
        data: {year: year},
        dataType: 'script'
      });
    });
  },
  disableMouseClick: function(){
    $('#learn_more, #syndication_title').on('click contextmenu',function(e){
      if(e.which == 2){e.preventDefault();};
      e.preventDefault();
    });
  },
  datePicker: function(){
    $('#syndication_close_date').datepicker({
      container: '.datepicker-main',
      dateFormat: 'mm/dd/yyyy',
      autoclose: true,
      todayHighlight: true
    });
  },
  documentOnReady: function(){
    this.pagintation();
    this.disableMouseClick();
    this.datePicker();
  },
  pageLoad: function(){
    this.pagintation();
    this.disableMouseClick();
    this.datePicker();
  }
}
$(document).ready(function(){
  Syndication.documentOnReady();
});
$(document).on('page:load', function(){
  Syndication.pageLoad();
});
$(window).on('load page:load',function(){
  $('img').unveil();
  $('#syndication_status').selectpicker();
});
