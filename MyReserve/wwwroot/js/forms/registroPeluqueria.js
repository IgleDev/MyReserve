$(document).ready(function () {

    $('#part2').hide(); // Ocultamos la parte 2
    $('#part3').hide(); // Ocultamos la parte 3
    function valNombre() { // Validamos campos
        let txtNombre = $('#txtNombre').val();
        let errorNombre = $('.text-danger').eq(0);
        if (txtNombre === undefined || txtNombre === '') {
            errorNombre.html('<h4>* Error al escribir el nombre</h4>');
            return false
        }
        errorNombre.text('');
        return true;
    }
    function valCorreo() {  // Validamos campos
        let validaEmail = new RegExp(/^(([^<>()\[\]\\.,;:\s@”]+(\.[^<>()\[\]\\.,;:\s@”]+)*)|(“.+”))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
        let txtCorreo = $('#txtCorreo').val();
        let errorCorreo = $('.text-danger').eq(1);
        if (!validaEmail.test(txtCorreo)) {
            errorCorreo.html('<h4>* Error en el correo electrónico</h4>');
            return false
        }
        errorCorreo.text('');
        return true;
    }

    function valContrasenha() { // Validamos campos
        let txtContrasenha = $('#txtContrasenha').val();
        let errorContrasenha = $('.text-danger').eq(2);
        if (txtContrasenha === undefined || txtContrasenha === '' || txtContrasenha.includes(' ')) {
            errorContrasenha.html('<h4>* Error al escribir la contraseña</h4>');
            return false
        }
        errorContrasenha.text('');
        return true;
    }

    function valPais() { // Validamos campos
        let txtPais = $('#listaPaises').val();
        let errorPais = $('.text-danger').eq(3);
        if (txtPais === '' || txtPais === null) {
            errorPais.html('<h4>* Elige un país</h4>');
            return false
        }
        errorPais.text('');
        return true;
    }

    function valRegion() { // Validamos campos
        let txtRegion = $('#listaRegiones').val();
        let errorRegion = $('.text-danger').eq(4);
        if (txtRegion === '' || txtRegion === null) {
            errorRegion.html('<h4>* Elige una Región </h4>');
            return false
        }
        errorRegion.text('');
        return true;
    }

    function valCiudad() { // Validamos campos
        let txtCiudad = $('#txtCiudad').val();
        let errorCiudad = $('.text-danger').eq(5);
        if (txtCiudad === '' || txtCiudad === null) {
            errorCiudad.html('<h4>* Elige una Ciudad </h4>');
            return false
        }
        errorCiudad.text('');
        return true;
    }

    function valDireccion() { // Validamos campos
        let txtDireccion = $('#txtDireccion').val();
        let errorDireccion = $('.text-danger').eq(6);
        if (txtDireccion === undefined || txtDireccion === '') {
            errorDireccion.html('<h4>* Error al escribir la calle</h4>');
            return false
        }
        errorDireccion.text('');
        return true;
    }

    function valTelefono() { // Validamos campos
        let txtTelefono = $('#txtTelefono').val();
        let errorTelefono = $('.text-danger').eq(7);
        if (txtTelefono === undefined || txtTelefono === '') {
            errorTelefono.html('<h4>* Error al escribir el teléfono</h4>');
            return false
        }
        errorTelefono.text('');
        return true;
    }

    function valGP() { // Validamos campos
        let txtGP = $('#txtGP').val();
        let errorGP = $('.text-danger').eq(8);
        if (txtGP === undefined || txtGP === '') {
            errorGP.html('<h4>* Error al escribir el grupo de peluquerías</h4>');
            return false
        }
        errorGP.text('');
        return true;
    }

    function validar() { // Validamos todos los campos
        let txtNombre = valNombre();
        let txtCorreo = valCorreo();
        let txtContrasenha = valContrasenha();
        let txtPais = valPais();
        let txtRegion = valRegion();
        let txtCiudad = valCiudad();
        let txtDireccion = valDireccion();
        let txtTelefono = valTelefono();
        let txtGP = valGP();
        if (txtNombre && txtCorreo && txtContrasenha && txtPais &&
            txtRegion && txtCiudad && txtDireccion && txtTelefono && txtGP) return true;
    }

    $('#btnPt1').click(function (e) { // Mostramos la parte 2 y ocultamos la 1
        $('#part1').hide();
        $('#part2').show();
    });

    $('#btnPt2').click(function (e) { // Mostramos la parte 3 y ocultamos la 2
        $('#part2').hide();
        $('#part3').show();
    });

    $('#btnPtV1').click(function (e) { // Mostramos la parte 1 y ocultamos la 2
        $('#part2').hide();
        $('#part1').show();
    });

    $('#btnPt3').click(function (e) { // Mostramos la parte 2 y ocultamos la 3
        $('#part3').hide();
        $('#part2').show();
    });

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

    $('#formRegistroPeluquerias').submit(function (e) { // Si todo valida mandamos el formulario
        e.preventDefault();
        if (validar()) this.submit();
    });
});