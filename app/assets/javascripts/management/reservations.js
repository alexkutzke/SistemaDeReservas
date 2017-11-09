function create_schedule(values) { // POST request to create a new schedule
  $.ajax({
      type: 'POST',
      url: $(this).attr('action'), //sumbits it to the given url of the form
      data: values,
      dataType: 'JSON'
  }).success(function(data){
      data['color'] = '#c3302c';
      $("#fullcalendar").fullCalendar( 'renderEvent', data);
      $('#new_event').modal('hide');
  }).error(function(error){
    error =  error["responseJSON"]["errors"];
    if (error.hasOwnProperty("title")) {
      $(".message-error").empty().append("Title " + error["title"]);
      $("#error").removeClass("hidden");
    }
  });
}

function destroy_schedule(id) { // DELETE request to destroy a schedule
  $('#schedule_destroy').prop('disabled', true);
  $("#error").addClass("hidden");
  $.ajax({
    type: 'DELETE',
    url: '/acesso/reservas/' + id,
    dataType: 'JSON'
  }).success(function(data) {
    $('#fullcalendar').fullCalendar('removeEvents', id);
    $('#show_schedule').modal('hide');
  }).error(function(error){
    if(error.status == 404) {
      $(".message-error").empty().append("Registro não encontrado");
      $("#error").removeClass("hidden");
    }
    $('#schedule_destroy').prop('disabled', false);
  });
}

function new_schedule(start, end) {
  if (moment(start).add(2, 'hours') < moment()){
    alert("Você não pode reservar uma data no passado...");
    $("#calendar").fullCalendar("unselect");
    return;
  }
  $('#schedule_title').val("");
  $('.schedule_date_range').val(moment(start).format("DD/MM/YYYY HH:mm") + ' - ' + moment(end).format("DD/MM/YYYY HH:mm"))
  $('.schedule_classroom_name').val($('.combo-classroom option:selected').text());
  $('.schedule_classroom').val($('.combo-classroom').val());
  $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
  $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
  $("#error").addClass("hidden");
  $('#new_event').modal('show');
  $('#new_event').on('shown.bs.modal', function(){
    $('#schedule_title').focus();
  });
}

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
      eventColor: '#2d3e50',
      monthNames: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
      monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
      dayNames: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
      dayNamesShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'],
      minTime: "06:00:00",
      maxTime: "23:00:00",
      hiddenDays: [0],
      height: 793,
      locale : 'pt-br',
      defaultView: "agendaWeek",
      selectable: true,
      selectHelper: true,
      editable: false,
      eventLimit: true,
      allDaySlot: false,
      slotEventOverlap: false,
      eventStartEditable: false,
      events: function(start, end, timezone, callback) {
        show_schedules(start, end, callback, "/acesso/reservas");
      },

      select: function(start, end) {
        new_schedule(start, end);
      },
      eventClick:  function(event, jsEvent, view) {
        var url = '/acesso/reservas/' + event.id;
        show_schedule(url);
      }
    });
  });
};

$(document).on('turbolinks:load', function() {
  initialize_calendar();

  // add new schedule
  $('#new_schedule').submit(function () {
    var valuesToSubmit = $(this).serialize(); // values from form
    create_schedule(valuesToSubmit);
    return false;
  });

  // remove a schedule
  $("#show_schedules_buttons").on('click', '#schedule_destroy', function(e) {
    var id = $(this).val();
    destroy_schedule(id);
  });
});
