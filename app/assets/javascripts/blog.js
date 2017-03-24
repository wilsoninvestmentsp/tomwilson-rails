Blog = {
  pagintation: function(){
    if ($('.pagination').length){
      $('#more_blogs').on('click', function() {
        var url = $('.pagination .next').children('a').attr('href');
        if(url){$.getScript(url);return false;}
      });
    }
  },
  clickableDiv: function(){
    $('.clickable_div').on('click', function(){
      window.location = $(this).find('a')[1]['href'];
    });
  },
  documentOnReady: function(){
    this.pagintation();
    this.clickableDiv();
  },
   pageLoad: function () {
    this.pagintation();
    this.clickableDiv();
  }
}
$(document).ready(function(){
  Blog.documentOnReady();
});
$(document).on('page:load', function(){
  Blog.pageLoad();
});
$(window).on('load page:load',function(){
  $('img').unveil();
});