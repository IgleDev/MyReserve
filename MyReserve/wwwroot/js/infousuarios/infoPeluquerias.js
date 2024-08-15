$(document).ready(function () {
    $('[data-bs-toggle="tooltip"]').tooltip();  // Activamos el tooltip para mostrar más información al usuario.

    var diaActualEntero = new Date(); // Cogemos la fecha de hoy
    var anhoActual = diaActualEntero.getFullYear();   // Cogemos el año actual
    var mesActual = String(diaActualEntero.getMonth() + 1).padStart(2, '0'); // Lo pasamos a String para poder mostrarlo y le sumamos uno porque Enero es el mes 0 y lo formateamos a 2 dígitos
    var diaActual = String(diaActualEntero.getDate()).padStart(2, '0');   // Formateamos a 2 dígitos el dia actual
    var fechaFinal = anhoActual + '-' + mesActual + '-' + diaActual;    // Montamos la fecha
    $('#fechaCita').attr('min', fechaFinal);    // Mandamos la fehca atraves del campo min indicando que la fecha que introduzcamos tiene que ser menor

    var pelu_id = $('#pelu_id').val(); // Verifica que esto esté inyectando el valor 

    $('#fechaCita').change(function () {    // Hacemos una funcion que se ejecute cuando el datepicker cambie
        var fechaCita = $(this).val();  // Recogemos la fecha

        $.ajax({    // Función AJAX para no tener que actualizar la página al hacer una petición GET
            url: '/InfoUsuarios/getHorariosDisponibles',    // Mandamos la URL
            type: 'GET',    // Específicamos el tipo
            data: { pelu_id: pelu_id, fechaCita:- fechaCita },   // Pasamos la información
            success: function (response) {  // Si esta bién
                $('#horariosDisponibles').empty(); // Limpiamos los horarios actuales
                if (!response || response.length === 0) {   // EN caso de que no haya horarios devolvemos un mensaje
                    $('#horariosDisponibles').append(`<p>No hay horarios disponibles para esta fecha.</p>`);
                    return;
                }
                $.each(response, function (index, horario) {    // Si no hacemos un bucle donde le pasamos toda la información
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
                console.error("Error al obtener los horarios disponibles:", error); // Específicamos el error en caso de fallo
            }
        });
    });

    function valPeluquero() {
        let peluqueroSeleccionado = $('input[name="peluquerosPeluqueria"]:checked').val();
        let errorPeluquero = $('.text-danger').eq(0);
        if (!peluqueroSeleccionado) {
            errorPeluquero.html('<h4>* Por favor, selecciona un peluquero.</h4>');
            return false;
        }
        errorPeluquero.text('');
        return true;
    }

    function valFechaCita() {
        let fechaCita = $('#fechaCita').val();
        let errorFecha = $('.text-danger').eq(1);
        if (fechaCita === undefined || fechaCita === '') {
            errorFecha.html('<h4>* Por favor, selecciona una fecha para la cita.</h4>');
            return false;
        }
        errorFecha.text('');
        return true;
    }

    function valHorario() {
        let horarioSeleccionado = $('input[name="horariosPeluqueria"]:checked').val();
        let errorHorario = $('.text-danger').eq(2);
        if (!horarioSeleccionado) {
            errorHorario.html('<h4>* Por favor, selecciona un horario.</h4>');
            return false;
        }
        errorHorario.text('');
        return true;
    }

    function valServicios() {
        let servicioSeleccionado = $('input[name="serviciosPeluqueria"]:checked').length > 0;
        let errorServicios = $('.text-danger').eq(3);
        if (!servicioSeleccionado) {
            errorServicios.html('<h4>* Por favor, selecciona un servicio.</h4>');
            return false;
        }
        errorServicios.text('');
        return true;
    }

    function validar() {
        let validoPeluquero = valPeluquero();
        let validoFecha = valFechaCita();
        let validoHorario = valHorario();
        let validoServicios = valServicios();
        return validoPeluquero && validoFecha && validoHorario && validoServicios;
    }

    $('#reservarCita').submit(function (e) {
        e.preventDefault();  // Previene el envío del formulario si no es válido
        if (validar()) this.submit();  // Envía el formulario solo si todas las validaciones son exitosas
    });

});