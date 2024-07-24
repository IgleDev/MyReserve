$(document).ready(function () {
    $('#peluqueros button').click(function () {
        $('#peluqueros button').removeClass('btn-success').addClass('btn-outline-primary');
        $(this).removeClass('btn-outline-primary').addClass('btn-success');
    });
});