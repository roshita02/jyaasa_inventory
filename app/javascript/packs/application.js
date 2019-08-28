// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels");
//= require jquery
//= require jquery_ujs
//= require bootstrap

$(document).on('turbolinks:load', function(){
  $('.navbar .dropdown').hover(function() {
      $(this).find('.dropdown-menu').first().stop(true, true).delay(250).slideDown();
  }, function() {
      $(this).find('.dropdown-menu').first().stop(true, true).delay(100).slideUp()
  });
})

$(document).ready(function(){
  var thehours = new Date().getHours();
	var themessage;
	var morning = ('Good morning');
	var afternoon = ('Good afternoon');
	var evening = ('Good evening');

	if (thehours >= 0 && thehours < 12) {
		themessage = morning; 

	} else if (thehours >= 12 && thehours < 17) {
		themessage = afternoon;

	} else if (thehours >= 17 && thehours < 24) {
		themessage = evening;
	}
	$('.greeting').append(themessage);

})
