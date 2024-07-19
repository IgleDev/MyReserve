$(document).ready(function () {
    $('#listaPais').change(function () {
        let pai_nombre = $(this).val();
        let regiones = $('#listaRegiones');
        regiones.empty();
        regiones.append('<option disabled value="">Seleccionar Región</option>');
        if (pai_nombre) {
            $.ajax({
                url: '/InfoUsuarios/getRegionesPais',
                type: 'GET',
                data: { pai_nombre: pai_nombre },
                success: function (data) {
                    console.log(data);
                    $.each(data, function (index, reg) {
                        regiones.append(`<option value="${reg.reg_nombre}">${reg.reg_nombre}</option>`);
                    });
                },
                error: function (xhr, status, error) {
                    console.error('Error:', error);
                }
            });
        }
    });
});