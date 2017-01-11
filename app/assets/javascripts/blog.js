Blog = {
  pagintation: function(){
    if ($('.pagination').length){
      $('#more_blogs').on('click', function() {
        var url = $('.pagination .next_page').attr('href');
        if(url)
        {
          $('.pagination').text("Please Wait...");
          return $.getScript(url);
        }
      });
    }
  },
  tinyMceEditor: function(selector){
    tinyMCE.init({
      selector: selector,
      min_height: 391
    });
  },
  documentOnReady: function(){
    this.pagintation();
  }
}
$(document).ready(function(){
  Blog.documentOnReady();
});