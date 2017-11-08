//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets

$( document ).ready(function() {
  $("[data-on-click]").on("click", function(e){
    window.location.href = $(this).data("on-click");
  });

  var page_title = document.title;

  function update_title_with_notification_count(){
    var notifications_count = $( ".navbar-nav .badge.notifications_count" ).text();
    if(parseInt(notifications_count) > 0) {
      document.title = '(' + notifications_count + ') ' + page_title;
    } else {
      document.title = page_title;
    }
  };

  update_title_with_notification_count();

  setInterval(function(){
    $.get( "/notifications/counter.json", function( data ) {
      var notifications_count = data.notifications_count;
      $( ".navbar-nav .badge.notifications_count" ).html(notifications_count);
      update_title_with_notification_count();
    });
  }, 120000); //2min
});
