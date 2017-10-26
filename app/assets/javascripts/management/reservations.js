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
        var todayDate = Date.now();
        if (start < todayDate){
          alert("Você não pode reservar uma data no passado...");
          $("#calendar").fullCalendar("unselect");
          return;
        }
        $('.event_date_range').val(moment(start).format("DD/MM/YYYY HH:mm") + ' - ' + moment(end).format("DD/MM/YYYY HH:mm"))
        $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
        $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
        $('#new_event').modal('show');

        // $.getScript('/events/new', function() {
        //   $('#event_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
        //   date_range_picker();
        //   $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
        //   $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
        // });

        calendar.fullCalendar('unselect');
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
              $(".event_title").val(doc["discipline"]["name"] + " / Turma: " + doc["klass"]["name"]);
            else
              $(".event_title").val(doc["title"]);
            $(".event_user").val(doc["user"]["name"]);
            $(".event_classroom").val(doc["classroom"]["room"]);
            $(".event_frequency").val(doc["frequency"]);
            $(".event_date_range").val(moment.utc(doc["start"]).format("DD/MM/YYYY HH:mm") + ' - ' + moment.utc(doc["end"]).format("DD/MM/YYYY HH:mm"));
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

$(document).on('turbolinks:load', initialize_calendar);
