var initialize_calendar;
initialize_calendar = function() {
  $('#fullcalendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      header: {
        center: 'title',
        left: 'prev,next',
        right: 'month,agendaWeek,agendaDay'
      },
      buttonText: {
        today: 'Hoje',
        month: 'mês',
        week: 'semana',
        day: 'dia'
      },
      timeFormat: 'H(:mm)',
      monthNames: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
      monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
      dayNames: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
      dayNamesShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'],
      hiddenDays: [0],
      minTime: "06:00:00",
      maxTime: "23:00:00",
      height: 793,
      locale : 'pt-br',
      defaultView: "agendaWeek",
      selectable: false,
      selectHelper: true,
      editable: false,
      eventLimit: true,
      allDaySlot: false,
      slotEventOverlap: false,
      events: function(start, end, timezone, callback) {
        $.ajax({
          url: '/reservas',
          type: 'GET',
          dataType: "json",
          contentType: "application/json; charset=utf-8",
          data: {
              start: moment(start).format('YYYY-MM-DD'),
              end: moment(end).format('YYYY-MM-DD'),
              classroom: $("#classroom").val()
          },
          success: function(doc) {
            var events = new Array();
            for(i=0;i<doc.length;i++) {
              if (doc[i]["state"] != 3 && doc[i]["state"] != 4) {
                event = new Object();
                event.id = doc[i]["id"];
                event.title = doc[i]["title"];
                event.reservation = doc[i]["reservation"];
                switch(doc[i]["state"]) {
                  case 1:
                    event.color = '#c3302c';
                    break;
                  case 2:
                    event.color = '#0e6b59';
                    break;
                }
                event.start = doc[i]["start"];
                event.end = doc[i]["end"];
                event.user_id = doc[i]["user_id"];
                events.push(event);
              }
            }
            callback(events);
          }
        });
      },
      //
      // viewRender: function (view, element) {
      //   var view = $('#fullcalendar').fullCalendar('getView');
      //   console.log("The view's title is " + view.name);
      //   $('#fullcalendar').fullCalendar('removeEvents');
      //   // $('#fullcalendar').fullCalendar('addEventSource', events_json);
      //   $('#fullcalendar').fullCalendar('rerenderEvents');
      // },
      // events: '/events.json',
      select: function(start, end) {},
      eventClick:  function(event, jsEvent, view) {
        $.ajax({
          url: '/reservas/' + event.id,
          type: 'GET',
          dataType: "json",
          contentType: "application/json; charset=utf-8",
          success: function(doc) {
            var event = new Object();
            if(doc.hasOwnProperty("discipline"))
              $("#event_title").val(doc["discipline"]["name"] + " / Turma: " + doc["klass"]["name"]);
            else
              $("#event_title").val(doc["title"]);
            $("#event_user").val(doc["user"]["name"]);
            $("#event_classroom").val(doc["classroom"]["room"]);
            $("#event_frequency").val(doc["frequency"]);
            $('#event_date_range').val(moment.utc(doc["start"]).format("DD/MM/YYYY HH:mm") + ' - ' + moment.utc(doc["end"]).format("DD/MM/YYYY HH:mm"))
            $('#show_event').modal('show');
          },
          error: function(doc) {
          }
        });
      }
    });
  });
};

$('.combo-classroom').change(function(){
  var selectedSite = $('.combo-classroom').val();
  var events = {
        url: '/classroom.json',
        type: 'GET',
        data: {
          siteid: selectedSite
        }
  }
  $('#calendar').fullCalendar('removeEventSource', events);
  $('#calendar').fullCalendar('addEventSource', events);
});

$(document).on('turbolinks:load', initialize_calendar);
$(document).ready(function(){

});
