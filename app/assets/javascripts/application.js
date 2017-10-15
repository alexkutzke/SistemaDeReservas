
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .
//= require moment
//= require fullcalendar
//= require fullcalendar/gcal

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
      monthNames: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
      monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
      dayNames: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
      dayNamesShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'],
      minTime: "06:00:00",
      maxTime: "23:00:00",
      height: 793,
      locale : 'pt-br',
      defaultView: "agendaWeek",
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      allDaySlot: false,
      slotEventOverlap: false,
      // events: [{
      //   title: 'event1',
      //   start: '2017-10-12'
      // }],
      events: function(start, end, timezone, callback) {
        $.ajax({
            url: '/reservas',
            dataType: 'json',
            data: {
                // our hypothetical feed requires UNIX timestamps
                start: moment(start).format('YYYY-MM-DD'),
                // start: start.unix(),
                end: moment(end).format('YYYY-MM-DD')
            },
            success: function(doc) {
                console.log("aquiii")
                console.log(doc)
            }
        });
      },
      // events: '/reservas.json',
      // events: [
      //   {
      //       title: 'My Event',
      //       start: '2017-10-14',
      //       end: '2017-10-14',
      //       description: 'This is a cool event',
      //       user: "Lais"
      //   }
      //   // more events here
      // ],
      eventRender: function(event, element) {
          console.log(event[0])
      },
      select: function(start, end, allDay) {
        $("#new-schedule").modal("show");
      },
      eventClick:  function(event, jsEvent, view) {
        // //set the values and open the modal
        // alert("chegou aqui");
        // // $("#eventInfo").html(event.description);
        // // $("#eventLink").attr('href', event.url);
        // // $("#eventContent").dialog({ modal: true, title: event.title });
      }
    });
  });
};
$(document).on('turbolinks:load', initialize_calendar);
