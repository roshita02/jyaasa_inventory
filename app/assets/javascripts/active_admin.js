//= require active_admin/base
//= require jquery
//= require jquery_ujs
//= require Chart.bundle
//= require chartkick
require("chartkick")
require("chart.js")

$(document).on('ready', function(){
  $('.categorylist').change(function(){
    id = $(this).val();
    $('.itemfilterlist').empty();
    $.get('/categories/'+ id + '/item_list', function(data, status){
      // alert("Data: " + data + "\nStatus: " + status);
      $.each(data, function (index, value) {
        $('.itemfilterlist').append('<option value= "'+ value[0]+ '">' + value[1] + '</option>')
      });

    });
  });
});