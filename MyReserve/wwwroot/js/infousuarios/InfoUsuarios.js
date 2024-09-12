$(document).ready(function () {
    $('#listaPais').change(function () { // Cada vez que se cambie de país se actualizará la información
        let pai_nombre = $(this).val(); // Recogemos el nombre del país
        let regiones = $('#listaRegiones'); // Recogemos la lista de las regiones
        regiones.empty();    // Vaciamos los options del select
        regiones.append('<option disabled value="">Seleccionar Región</option>'); // Añadimos la línea de default

        if (pai_nombre) {   // Si hay nombre del país hacemos lo siguiente
            $.ajax({    // Función ajax
                url: '/Formularios/getRegionesPais',    // Pasamos la URL que tenemos en el controller
                type: 'GET',    // Tipo GET
                data: { pai_nombre: pai_nombre },   // Se envía el nombre del país como parámetro de consulta
                success: function (data) {  // Si la operación es exitosa (Código 200)
                    $.each(data, function (index, reg) {    // Bucle foreach que nos muestre los nombres de las regiones
                        regiones.append(`<option value="${reg.reg_nombre}">${reg.reg_nombre}</option>`);    // Las añadimos
                    });
                },
                error: function (xhr, status, error) {  // En caso de fallo pues muestra el error
                    console.error('Error:' + error);
                }
            });
        }
    });
});