Blog = {
  pagintation: function(){
    if ($('.pagination').length){
      $('#more_blogs').on('click', function() {
        var url = $('.pagination .next').children('a').attr('href');
        if(url){$.getScript(url);return false;}
      });
    }
  },
  documentOnReady: function(){
    this.pagintation();
  },
   pageLoad: function () {
    this.pagintation();
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