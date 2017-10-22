
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
//= require daterangepicker

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
      events: '/events.json',
      select: function(start, end) {
          //here I validate that the user can't create an event before today
        var todayDate = Date.now();
        if (start < todayDate){
          alert("Você não pode reservar uma data no passado...");
          $("#calendar").fullCalendar("unselect");
          return;
        }
        $.getScript('/events/new', function() {
          $('#event_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
          date_range_picker();
          $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
          $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
        });

        calendar.fullCalendar('unselect');
      },
      eventDrop: function(event, delta, revertFunc) {
        event_data = {
          event: {
            id: event.id,
            start: event.start.format(),
            end: event.end.format()
          }
        };
        $.ajax({
            url: event.update_url,
            data: event_data,
            type: 'PATCH'
        });
      },
      eventClick: function(event, jsEvent, view) {
        $.getScript(event.edit_url, function() {
          $('#event_date_range').val(moment(event.start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(event.end).format("MM/DD/YYYY HH:mm"))
          date_range_picker();
          $('.start_hidden').val(moment(event.start).format('YYYY-MM-DD HH:mm'));
          $('.end_hidden').val(moment(event.end).format('YYYY-MM-DD HH:mm'));
        });
      }
    });
      // events: function(start, end, timezone, callback) {
      //   $.ajax({
      //       url: '/reservas',
      //       dataType: 'json',
      //       data: {
      //           start: moment(start).format('YYYY-MM-DD'),
      //           end: moment(end).format('YYYY-MM-DD')
      //       },
      //       success: function(doc) {
      //         console.log(doc[0]);
      //           var events = new Array();
      //           for(i=0;i<doc.length;i++) {
      //             event = new Object();
      //             event.id = doc[i]["id"];
      //             event.reservation = doc[i]["reservation"];
      //             event.color = doc[i]["reservation"] ? '#cccccc' : '#000000';
      //             event.start = doc[i]["start_at"];
      //             event.end = doc[i]["end_at"];
      //             event.user_id = doc[i]["user"]["id"];
      //             event.user_name = doc[i]["user"]["name"];
      //             events.push(event);
      //           }
      //           callback(events);
      //       }
      //   });
      // },
      // eventRender: function(event, element, view){
      //   console.log(element);
      // },
        // viewRender: function(view, element) {
        // var events = $('#fullcalendar').fullCalendar('clientEvents');
        // handleViewChange(events);

      // eventRender: function(event, element) {
      //   element.find('.fc-title').append("<br/>Nome: " + event.id);
      //     element.attr('id', event.id);
      // },
      // select: function(start, end, allDay) {
      //   $("#new-schedule").modal("show");
      // },
      // eventClick:  function(event, jsEvent, view) {
      //   // //set the values and open the modal
      //   // alert("chegou aqui");
      //   // // $("#eventInfo").html(event.description);
      //   // // $("#eventLink").attr('href', event.url);
      //   // // $("#eventContent").dialog({ modal: true, title: event.title });
      // }
    });
};

$(document).on('turbolinks:load', initialize_calendar);
