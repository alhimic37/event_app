var CalendarController = Paloma.controller('Calendar');

// Executes when Rails Calendar#index is executed.
CalendarController.prototype.index = function(){
  var eventsSource = this.params['eventsSource'];

 $(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
  
	$('#calendar').fullCalendar({
		editable: true,        
		header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        defaultView: 'month',
        height: 500,
        slotMinutes: 15,
        
        loading: function(bool){
            if (bool) 
                $('#loading').show();
            else 
                $('#loading').hide();
            
        },
        
        // a future calendar might have many sources.        
        eventSources: [{
            url: eventsSource,
            color: 'blue',
            textColor: 'black',
            ignoreTimezone: false
        }],
        
        timeFormat: {
            // for agendaWeek and agendaDay
            agenda: 'H:mm{ - H:mm}', // 5:00 - 6:30

            // for all other views
            '': 'H:mm'            // 7
        },
    
        dragOpacity: "0.5",
        
        //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
        eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/event_ui/eventResize/
        eventResize: function(event, dayDelta, minuteDelta, revertFunc){
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/mouse/eventClick/
        eventClick: function(event, jsEvent, view){
       
        },
    
        dayClick: function(date, allDay, jsEvent, view) {
          $.get('events/new', {date: date});
        },
    
    });
   
   
  });
function updateEvent(the_event) {
    $.update(
      "/events/" + the_event.id,
      { event: { title: the_event.title,
                 start_at: "" + the_event.start,
                 end_at: "" + the_event.end,
                 description: the_event.description
               }
      },
      function (reponse) { alert('successfully updated task.'); }
    );
}
}