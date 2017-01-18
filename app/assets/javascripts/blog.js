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
  clickableDiv: function(){
    $('.listing-box, .propery-box').on('click', function(){
      if($(this).attr('class') == 'listing-box'){
        var property_url = $(this).find('h3').children('a')[0]['href'];
      }else{
       var property_url = $(this).find('a')[1]['href'];
      }
      window.location = property_url;
    })
  }, 
  documentOnReady: function(){
    this.pagintation();
    this.clickableDiv();
  }
}
$(document).ready(function(){
  Blog.documentOnReady();
});