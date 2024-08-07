$(document).ready(function () {
    var diaActualEntero = new Date(); // Cogemos la fecha de hoy
    var anhoActual = diaActualEntero.getFullYear();   // Cogemos el año actual
    var mesActual = String(diaActualEntero.getMonth() + 1).padStart(2, '0'); // Lo pasamos a String para poder mostrarlo y le sumamos uno porque Enero es el mes 0 y lo formateamos a 2 dígitos
    var diaActual = String(diaActualEntero.getDate()).padStart(2, '0');   // Formateamos a 2 dígitos el dia actual
    var fechaFinal = anhoActual + '-' + mesActual + '-' + diaActual;    // Montamos la fecha
    $('#fechaCita').attr('min', fechaFinal);    // Mandamos la fehca atraves del campo min indicando que la fecha que introduzcamos tiene que ser menor
});