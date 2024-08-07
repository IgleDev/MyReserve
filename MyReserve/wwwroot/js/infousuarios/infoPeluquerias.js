$(document).ready(function () {
    var diaActualEntero = new Date(); // Cogemos la fecha de hoy
    var anhoActual = diaActualEntero.getFullYear();   // Cogemos el año actual
    var mesActual = String(diaActualEntero.getMonth() + 1).padStart(2, '0'); // Lo pasamos a String para poder mostrarlo y le sumamos uno porque Enero es el mes 0 y lo formateamos a 2 dígitos
    var diaActual = String(diaActualEntero.getDate()).padStart(2, '0');   // Formateamos a 2 dígitos el dia actual
    var fechaFinal = anhoActual + '-' + mesActual + '-' + diaActual;    // Montamos la fecha
    $('#fechaCita').attr('min', fechaFinal);    // Mandamos la fehca atraves del campo min indicando que la fecha que introduzcamos tiene que ser menor

    var pelu_id = $('#pelu_id').val(); // Verifica que esto esté inyectando el valor correcto

    $('#fechaCita').change(function () {
        var fechaCita = $(this).val();
        console.log("Fecha de cita: " + fechaCita);

        $.ajax({
            url: '/InfoUsuarios/ObtenerHorariosDisponibles',
            type: 'GET',
            data: { pelu_id: pelu_id, fechaCita: fechaCita },
            success: function (response) {
                $('#horariosDisponibles').empty(); // Limpia los horarios actuales
                if (!response || response.length === 0) {
                    $('#horariosDisponibles').append(`<p>No hay horarios disponibles para esta fecha.</p>`);
                    return;
                }
                $.each(response, function (index, horario) {
                    $('#horariosDisponibles').append(
                        `<div class="d-inline-flex flex-wrap mb-2">
                                <div class="d-inline-flex flex-wrap mb-2">
                                    <div class="form-check">
                                        <input type="radio" class="btn-check" autocomplete="off" name="horariosPeluqueria"
                                               value="${horario.hora_id}" id="btn-check-horarios-${horario.hora_id}" />
                                        <label class="btn" for="btn-check-horarios-${horario.hora_id}">${horario.hora_fecha}</label>
                                    </div>
                                </div>
                            </div>`
                    );
                });
            },
            error: function (xhr, status, error) {
                console.error("Error al obtener los horarios disponibles:", error);
            }
        });
    });
});