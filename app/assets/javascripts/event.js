jQuery(document).ready(function($) {  
  
  $(".ec-event").find("a").attr('data-remote', 'true');
  
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
        $(this).append("<a id='NewEvent' href='events/new' data-remote='true'></a>");
        $("#NewEvent").click().remove();
      }
  });