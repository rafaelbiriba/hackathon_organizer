//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets

$( document ).ready(function() {
  $("[data-on-click]").on("click", function(e){
    window.location.href = $(this).data("on-click");
  })

  setInterval(function(){
    $.get( "/notifications/counter.json", function( data ) {
      $( ".navbar-nav .badge.notifications_count" ).html( data.notifications_count );
    });
  }, 300000); //5min
});
