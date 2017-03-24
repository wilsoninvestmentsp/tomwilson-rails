Properties = {
  pagintation: function(){
    if ($('.pagination').length){
      $('#more_properties').on('click', function(){
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
  defaultActiveBuildingType: function(){
    $('a:contains("All")').parent('li').addClass('active');
  },
  filterByBuildingType: function(){
    $('#building_type_menu li').on('click', function(){
      var building_type = $(this).attr('building_type');
      $('#building_type_menu li').removeClass('active');
      $(this).addClass('active');
      $.ajax({
        url: '/properties',
        data: {building_type: building_type},
        dataType: 'script'
      });
    })
  },
  documentOnReady: function(){
    this.pagintation();
    this.filterByBuildingType();
    this.clickableDiv();
    this.defaultActiveBuildingType();
  },
  pageLoad: function () {
    Properties.documentOnReady();
  }
}
$(document).ready(function(){
  Properties.documentOnReady();
});
$(document).on('page:load', function(){
  Properties.pageLoad();
});
$(window).on('load page:load',function(){
  $('img').unveil();
});