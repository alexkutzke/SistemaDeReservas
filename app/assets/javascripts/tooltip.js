$(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip();
});

$(window).on('resize', function () {
  $('[data-toggle="tooltip"]').tooltip();
})
