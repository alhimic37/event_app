/*
 * Smart event highlighting
 * Handles when events span rows, or don't have a background color
 */
jQuery(document).ready(function($) {
  
  var prevMonthName = $(".ec-previous-month").find("a").text();
  var curMonthName = $(".ec-month-name").text().split(" ")[0];
  var year = $(".ec-month-name").text().split(" ")[1];
  var nextMonthName = $(".ec-next-month").find("a").text();
  var rows = $(".ec-row");

  
  $.each(rows, function(i, row){
      var days = $(row).find(".ec-day-bg");
      var numDays = $(row).find(".ec-row-table").find(".ec-day-header").map(function(i, el){
          return $(el).text();
      });
      
      $.each(days, function(j, day){
          if(!$(day).hasClass(".ec-other-month-bg")){
            $(day).attr('id', year + curMonthName + numDays[j]);
          } 
      });
  });
  
  
  $(".ec-event-cell").find("a").attr('data-remote', 'true');
  
  $(".ec-day-bg").on("mouseover", function(){
      if(!$(this).hasClass("ec-other-month-bg")){
        $(this).addClass("ec-day-highlighted");
      }
  });
  $(".ec-day-bg").on("mouseleave", function(){
      if(!$(this).hasClass("ec-other-month-bg")){
        $(this).removeClass("ec-day-highlighted");
      }
  });
      
  $(".ec-day-bg").on("dblclick", function(){
      if(!$(this).hasClass("ec-other-month-bg")){
        $(this).append("<a id='NewEvent' href='/events/new' data-remote='true'></a>");
        $("#NewEvent").click().remove();
      }
  });
  
  
});