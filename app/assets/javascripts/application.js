//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets

$( document ).ready(function() {
    $("[data-on-click]").on("click", function(e){
      window.location.href = $(this).data("on-click");
    })
});
