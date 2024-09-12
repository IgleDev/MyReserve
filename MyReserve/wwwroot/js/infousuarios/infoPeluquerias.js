$(document).ready(function () {
    $('[data-bs-toggle="tooltip"]').tooltip();  // Activamos el tooltip para mostrar más información al usuario.

    let fechaActual = new Date();
    flatpickr("#fechaCita", {
        minDate: fechaActual, // Podemos que la fecha mínima es hoy
        disable: [  // Deshabilitamos los domingos
            function (date) {
                return (date.getDay() === 0);   // Domingos es 0
            }
        ],
        locale: {
            "firstDayOfWeek": 1 // Para que empieze la semana un lunes
        },
        dateFormat: "Y-m-d", // Ponemos formato a la fecha para que filtre bien
    });

    $('#fechaCita').on('change', function () {
        let fechaCita = $(this).val(); // pillamos la fecha del input
        let usu_id = $('#usu_id').val(); // pillamos el ID del usuario
        
        $.ajax({    // Función AJAX para no tener que actualizar la página al hacer una petición GET
            url: '/InfoUsuarios/getCitaUsuario',    // Indicamos URL
            type: 'GET',    // Tipo de URL
            data: { usu_id: usu_id, fechaCita: fechaCita }, // Le pasamos los datos
            success: function (response) {  
                if (response.success) { // Si la respuesta es correcta
                    $('#horariosDisponibles').show();   // Mostramos horarios
                    $('#cita').text(''); // Limpiar el mensaje de error
                    actualizarHorarios();    // Actualizamos los horarios disponibles
                } else {    // En caso de que sea false y el usuario ya tenga una cita ese día
                    $('#horariosDisponibles').hide();   // Ocultamos los horarios
                    $('#cita').text(`<h4>${response.message}</h4>`); // Mostramos el mensaje de error
                }
            },
            error: function (xhr, status, error) {
                console.error("Error al verificar la cita:" + error);  // Específicamos el error en caso de fallo
            }
        });
    });

    function actualizarHorarios() {
        var pel_id = $('input[name="peluquerosPeluqueria"]:checked').val(); // ID del peluquero seleccionado
        var fechaCita = $('#fechaCita').val(); // Fecha seleccionada

        $.ajax({    // Función AJAX para no tener que actualizar la página al hacer una petición GET
            url: '/InfoUsuarios/getHorariosDisponibles',    // Mandamos la URL
            type: 'GET',   // Específicamos el tipo 
            data: { pel_id: pel_id, fechaCita: fechaCita }, // Pasamos la información
            success: function (respuesta) {  // Si esta bién
                $('#horariosDisponibles').empty();  // Limpiamos los horarios actuales

                if (!respuesta || respuesta.length === 0) {   // EN caso de que no haya horarios devolvemos un mensaje
                    $('#horariosDisponibles').html('<p>No hay horarios disponibles para esta fecha y peluquero.</p>');
                    return;
                }

                $.each(respuesta, function (index, horario) {    // Si no hacemos un bucle donde le pasamos toda la información
                    $('#horariosDisponibles').append(
                        `<div class="d-inline-flex flex-wrap mb-2">
                        <div class="form-check">
                            <input type="radio" class="btn-check" autocomplete="off" name="horariosPeluqueria"
                                   value="${horario.hora_id}" id="btn-check-horarios-${horario.hora_id}" />
                            <label class="btn" for="btn-check-horarios-${horario.hora_id}">${horario.hora_fecha}</label>
                        </div>
                    </div>`
                    );
                });
            },
            error: function (xhr, status, error) {
                console.error("Error al obtener los horarios disponibles:" + error);  // Específicamos el error en caso de fallo
            }
        });
    }

    $('#fechaCita').change(function () {    // Cada vez que cambie llamamos de nuevo a la función
        actualizarHorarios();
    });

    $('input[name="peluquerosPeluqueria"]').change(function () {    // Cada vez que cambie llamamos de nuevo a la función
        actualizarHorarios();
    });

    function valPeluquero() {   // Validamos Campos
        let peluqueroSeleccionado = $('input[name="peluquerosPeluqueria"]:checked').val();
        let errorPeluquero = $('.text-danger').eq(0);
        if (!peluqueroSeleccionado) {
            errorPeluquero.html('<h4>* Por favor, selecciona un peluquero.</h4>');
            return false;
        }
        errorPeluquero.text('');
        return true;
    }

    function valFechaCita() {   // Validamos campos
        let fechaCita = $('#fechaCita').val();
        let errorFecha = $('.text-danger').eq(1);
        if (fechaCita === undefined || fechaCita === '') {
            errorFecha.html('<h4>* Por favor, selecciona una fecha para la cita.</h4>');
            return false;
        }
        errorFecha.text('');
        return true;
    }

    function valHorario() { // Validamos campos
        let horarioSeleccionado = $('input[name="horariosPeluqueria"]:checked').val();
        let errorHorario = $('.text-danger').eq(2);
        if (!horarioSeleccionado) {
            errorHorario.html('<h4>* Por favor, selecciona un horario.</h4>');
            return false;
        }
        errorHorario.text('');
        return true;
    }

    function valServicios() {   // Validamos campos
        let servicioSeleccionado = $('input[name="serviciosPeluqueria"]:checked').length > 0;
        let errorServicios = $('.text-danger').eq(3);
        if (!servicioSeleccionado) {
            errorServicios.html('<h4>* Por favor, selecciona un servicio.</h4>');
            return false;
        }
        errorServicios.text('');
        return true;
    }

    function validar() {   // Validamos campos 
        let validoPeluquero = valPeluquero();
        let validoFecha = valFechaCita();
        let validoHorario = valHorario();
        let validoServicios = valServicios();
        return validoPeluquero && validoFecha && validoHorario && validoServicios;
    }

    $('#reservarCita').submit(function (e) {    // Si todo va bien mandamos el formulario
        e.preventDefault(); 
        if (validar()) this.submit();
    });

});