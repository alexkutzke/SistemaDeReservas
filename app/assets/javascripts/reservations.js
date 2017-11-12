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
      contentHeight: 'auto',
      locale : 'pt-br',
      defaultView: "agendaWeek",
      selectable: false,
      selectHelper: true,
      editable: false,
      eventLimit: true,
      allDaySlot: false,
      slotEventOverlap: false,
      events: function(start, end, timezone, callback) {
        show_schedules(start, end, callback, "/reservas");
      },
      eventClick:  function(event, jsEvent, view) {
        var url = '/reservas/' + event.id;
        show_schedule(url);
      }
    });
  });
};

$(document).on('turbolinks:load', function() {
  initialize_calendar();
  $('.datepicker').datepicker({
    showOn: 'button',
    clearBtn: true,
    daysOfWeekDisabled: ['0'],
    format: 'dd/mm/yyyy',
    language: 'pt-BR',
    todayHighlight: true,
    showOn: 'both'
  }).on('changeDate', function(ev) {
    var selectedClassroom = $('.combo-classroom').val();
    var data = ev.format(0,"yyyy-mm-dd");
    $.ajax({
      url: '/reservas',
      type: 'GET',
      dataType: "json",
      contentType: "application/json; charset=utf-8",
      data: {
        classroom: selectedClassroom,
        start: data + " 00:00:00",
        end: data + "23:59:59",
        by_day:  true
      },
      success:  function(data) {
        if(data.length>0) {
          var d = moment(data[0]["start"]).format("YYYY-MM-DD");
          $('#fullcalendar').fullCalendar('gotoDate',  data["start"]);
        }
        $('#fullcalendar').fullCalendar('removeEvents');
        $("#fullcalendar").fullCalendar( 'renderEvents', data);
      },
      error: function(error) {
        console.log(error);
      }
    });
  });
  set_fullcalendar_table();
  $('.datepicker-days').addClass('table-responsive');
  $('.table-condensed').addClass('table table-striped');
  $('.combo-classroom').change(function(){
    get_schedules_from_classroom();
  });
});
