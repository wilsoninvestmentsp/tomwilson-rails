Jasset = {
  sortByDate: function(){
    $('#order_date, #link_name').on('change', function(){
      if($('#order_date').val()){var order_date = $('#order_date').val();}
      if($('#link_name').val()){var link_name = $('#link_name').val();}
      $.ajax({
        url: '/resources',
        data: {
          order_date: order_date,
          link_name: link_name
        },
        dataType: 'script'
      });
    });
  },
  documentOnReady: function(){
    this.sortByDate();
  },
  pageLoad: function () {
    this.sortByDate();
  }
}
$(document).ready(function(){
  Jasset.documentOnReady();
});
$(document).on('page:load', function(){
  Jasset.pageLoad();
});
$(window).on('load page:load',function(){
  $('#order_date, #link_name').selectpicker({dropupAuto: false});
  $('img').unveil();
});