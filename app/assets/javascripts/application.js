// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.ui.all
//= require jquery.timepicker
//= require fullcalendar
//= require lazybox
//= require paloma
//= require_tree ./sitewide
//= require_tree ./paloma/
//= require jquery.rest
//= require turbolinks
//= require bootstrap

$.rails.allowAction = $.lazybox.confirm;

$.ajaxSetup({
  beforeSend: function(xhr) {
    xhr.setRequestHeader("Accept", "text/javascript");
  }
});

$.lazybox.settings = {cancelClass: "btn btn-warning", submitClass: 'btn btn-danger', overlay: false}

$(document).ready(function() {
  $('a[rel*=lazybox]').lazybox();
  // or with options
  $('a[rel*=lazybox]').lazybox({overlay: true, esc: true, close: true, modal: true, klass: 'class', speed: 1});
  
  $('.datepicker').datepicker({ dateFormat: 'dd.mm.yy'});
});




