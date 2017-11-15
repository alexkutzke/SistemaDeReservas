var states = ["Aguardando aprovação", "Aprovado", "Recusado", "Cancelado"];

function show_schedules(start, end, callback, url) { // render schedules on fullcalendar
  $.ajax({
    url: url,
    type: 'GET',
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    data: {
        start: moment(start).format('YYYY-MM-DD'),
        end: moment(end).format('YYYY-MM-DD'),
        classroom: $("#classroom").val()
    },
    success: function(data) {
      var events = set_events_array(data);
      callback(events);
    }
  });
}

function show_schedule(url) {
  $.ajax({
    url: url,
    type: 'GET',
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    success: function(data) {
      console.log(data);
      var event = new Object();
      $("#schedule_destroy").remove();
      if (data["can_destroy"]) // check case if user can remove schedule - add remove button
        $("#show_schedules_buttons").append('<button type="button"  value=' + data["id"] + ' class="btn btn-danger" id="schedule_destroy">Excluir</button>');

      if(data.hasOwnProperty("discipline"))
        $(".schedule_title").val(data["klass"]["name"] + " - " + data["discipline"]["discipline_code"] + data["discipline"]["name"]);
      else
        $(".schedule_title").val(data["title"]);

      if(data.hasOwnProperty("user"))
        $(".schedule_user").val(data["user"]["name"]);
      else
        $(".schedule_user").val("");
      $(".schedule_classroom").val(data["classroom"]["room"]);
      $(".schedule_frequency").val(data["frequency"]);
      $(".schedule_date_range").val(moment.utc(data["start"]).format("DD/MM/YYYY HH:mm") + ' - ' + moment.utc(data["end"]).format("DD/MM/YYYY HH:mm"));
      $("#schedule_state").val(states[data["state"]-1]);
      $("#error").addClass("hidden");
      $('#show_schedule').modal('show');
    },
    error: function(error) {
    }
  });
}

function set_events_array(data) {
  var events = new Array();
  for(i=0;i<data.length;i++) {
    /*
     * States:
     *  - 1 (Pendente)
     *  - 2 (Aprovado)
     *  - 3 (Recusado)
     *  - 4 (Cancelado)
     */
    if (data[i]["state"] == 1 || data[i]["state"] == 2) {
      event = new Object();
      if (data[i]["discipline_id"] != null && data[i]["klass_id"] != null)
        event.title = data[i]["klass"]["name"] + " - " + data[i]["discipline"]["discipline_code"] + data[i]["discipline"]["name"];
      else
        event.title = data[i]["title"];
      event.id = data[i]["id"];
      event.reservation = data[i]["reservation"];
      event.color = data[i]["color"];
      event.start = data[i]["start"];
      event.end = data[i]["end"];
      event.user_id = data[i]["user_id"];
      events.push(event);
    }
  }

  return events;
}

/*
 * Call this function when user change classroom combobox
 * to make a ajax request and get schedules from this classroom
 */
function get_schedules_from_classroom() {
  var selectedClassroom = $('.combo-classroom').val();
  var start = $('#fullcalendar').fullCalendar('getView').start;
  var end = $('#fullcalendar').fullCalendar('getView').end;
  $.ajax({
    url: '/reservas',
    type: 'GET',
    dataType: "json",
    contentType: "application/json; charset=utf-8",
    data: {
      classroom: selectedClassroom,
      start: moment(start).format('YYYY-MM-DD'),
      end:  moment(end).format('YYYY-MM-DD')
    },
    success:  function(data) {
        var events = set_events_array(data);
        $('#fullcalendar').fullCalendar('removeEvents');
        $("#fullcalendar").fullCalendar( 'renderEvents', events);
    },
    error: function(error) {
      console.log(error);
    }
  });
}

function set_fullcalendar_table() {
  $('.fc-agendaWeek-button').on('click', function() {
    $(".fc-agendaWeek-view").children('table').css('min-width', '650px');
  });
  $('.fc-month-button').on('click', function() {
    $(".fc-month-view").children('table').css('min-width', '650px');
  });
  $(".fc-agendaWeek-view").children('table').css('min-width', '650px');
  $(".fc-view-container").addClass("table-responsive");
}
