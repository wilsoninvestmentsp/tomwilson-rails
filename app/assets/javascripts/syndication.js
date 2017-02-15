Syndication = {
  pagintation: function(){
    if ($('.pagination').length){
      $('#more_syndication').on('click', function(){
        var url = $('.pagination .next').children('a').attr('href');
        if(url){return $.getScript(url);}
      });
    }
  },
  databyYear: function(){
    $('#syndication_years').on('change', function(){
      var year = $(this).val();
      $.ajax({
        url: '/investor-performance/'+$('#slug_id').val(),
        data: {year: year},
        dataType: 'script'
      });
    });
  },
  datepicker: function(){
    $('.datepicker').datepicker({format: 'mm/dd/yyyy'})
  },
  disableMouseClick: function(){
    $('#learn_more, #syndication_title').on('click contextmenu',function(e){
      if(e.which == 2){e.preventDefault();};
      e.preventDefault();
    });
  },
  documentOnReady: function(){
    this.pagintation();
    this.disableMouseClick();
    this.datepicker();
  },
  pageLoad: function(){
    this.pagintation();
    this.disableMouseClick();
    this.datepicker();
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
});
