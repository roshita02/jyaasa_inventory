// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
// require("turbolinks").start()
require("@rails/activestorage").start()
require("channels");
//= require active_admin
//= require jquery
//= require jquery_ujs
//= require popper
//= require parsley
//= require bootstrap
//= require bootstrap-dropdown

require("chartkick")
require("chart.js")

$(document).ready(function(){
  $('.navbar .dropdown').hover(function() {
      $(this).find('.dropdown-menu').first().stop(true, true).delay(250).slideDown();
  }, function() {
      $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideUp()
    });
    $('.close').click(function() {
        $(".alert-dismissible").css("display", "none")
    });
})



