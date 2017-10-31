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
      events: function(start, end, timezone, callback) {
        $.ajax({
          url: '/acesso/reservas',
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
              event = new Object();
              event.title = doc[i]["title"];
              event.id = doc[i]["id"];
              event.reservation = doc[i]["reservation"];
              event.color = doc[i]["reservation"] ? '#000000' : '#cccccc';
              event.start = doc[i]["start"];
              event.end = doc[i]["end"];
              event.user_id = doc[i]["user_id"];
              events.push(event);
            }
            callback(events);
          }
        });
      },

      select: function(start, end) {
          //here I validate that the user can't create an event before today
        // console.log("moment = " + moment());
        // console.log("moment = " + moment().format("DD/MM/YYYY HH:mm"));
        // console.log("start = " + start);
        // console.log("start = " + moment(start).format("DD/MM/YYYY HH:mm"));
        // console.log(moment.utc(start) < moment());
        // console.log(moment(start).format("DD/MM/YYYY HH:mm") < moment().format("DD/MM/YYYY HH:mm"));
        if (moment(start) < moment()){
          alert("Você não pode reservar uma data no passado...");
          $("#calendar").fullCalendar("unselect");
          return;
        }
        $('.schedule_date_range').val(moment(start).format("DD/MM/YYYY HH:mm") + ' - ' + moment(end).format("DD/MM/YYYY HH:mm"))
        $('.schedule_classroom').val($('.combo-classroom').text());
        $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
        $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
        $('#new_event').modal('show');
      },
      eventClick:  function(event, jsEvent, view) {
        $.ajax({
          url: '/acesso/reservas/' + event.id,
          type: 'GET',
          dataType: "json",
          contentType: "application/json; charset=utf-8",
          success: function(doc) {
            var event = new Object();
            if(doc.hasOwnProperty("discipline"))
              $(".schedule_title").val(doc["discipline"]["name"] + " / Turma: " + doc["klass"]["name"]);
            else
              $(".schedule_title").val(doc["title"]);
            $(".schedule_user").val(doc["user"]["name"]);
            $(".schedule_classroom").val(doc["classroom"]["room"]);
            $(".schedule_frequency").val(doc["frequency"]);
            $(".schedule_date_range").val(moment.utc(doc["start"]).format("DD/MM/YYYY HH:mm") + ' - ' + moment.utc(doc["end"]).format("DD/MM/YYYY HH:mm"));
            $('#show_event').modal('show');
          },
          error: function(doc) {
          }
        });
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

$("#new_schedule").submit(function(e) {
  if (1>2) {
     $("#submitBet").submit();
  }
  console.log(here);
  e.preventDefault();
});

$("#new_schedule_button").on('click', function(e) {
  // console.log(here);
  // e.preventDefault();
  if (1>2) {
     $("#new_schedule_button").submit();
  }
});

$(document).on('turbolinks:load', initialize_calendar);
