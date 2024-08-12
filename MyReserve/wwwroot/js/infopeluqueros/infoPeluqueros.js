$(document).ready(function () {

    $('#part2').hide(); // Ocultamos la parte 2
    $('#part3').hide(); // Ocultamos la parte 3

    function valNombre() {  // Validamos campos
        let txtNombre = $('#txtNombre').val();
        let errorNombre = $('.text-danger').eq(0);
        if (txtNombre === undefined || txtNombre === '' || txtNombre.includes(' ')) {
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
            errorCorreo.html('<h4>* Error en el correo electrónico o en uso</h4>');
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

    function valDescripcion() { // Validamos campos
        let txtDescripcion = $('#txtDescripcion').val();
        let errorDescripcion = $('.text-danger').eq(3);
        if (txtDescripcion === undefined || txtDescripcion === '') {
            errorDescripcion.html('<h4>* Error al escribir la descripción</h4>');
            return false
        }
        errorDescripcion.text('');
        return true;
    }

    function valExperiencia() { // Validamos campos
        let txtExperiencia = $('#txtExperiencia').val();
        let errorExperiencia = $('.text-danger').eq(4);
        if (txtExperiencia === undefined || txtExperiencia === '' || txtExperiencia.includes(' ')) {
            errorExperiencia.html('<h4>* Error al escribir la experiencia</h4>');
            return false
        }
        errorExperiencia.text('');
        return true;
    }

    function valRRSS() { // Validamos campos
        let txtRRSS = $('#txtRRSS').val();
        let errorRRSS = $('.text-danger').eq(5);
        if (txtRRSS === undefined || txtRRSS === '' || txtRRSS.includes(' ')) {
            errorRRSS.html('<h4>* Error al escribir tu instagram</h4>');
            return false
        }
        errorRRSS.text('');
        return true;
    }

    function validar() { // Validamos campos
        let txtNombre = valNombre();
        let txtCorreo = valCorreo();
        let txtContrasenha = valContrasenha();
        let txtDescripcion = valDescripcion();
        let txtExperiencia = valExperiencia();
        let txtRRSS = valRRSS();
        if (txtNombre && txtCorreo && txtContrasenha && txtDescripcion && txtExperiencia && txtRRSS) return true;
    }

    $('#btnPt1').click(function (e) {   // Mostramos la parte 2 y ocultamos la 1
        $('#part1').hide();
        $('#part2').show();
    });

    $('#btnPt2').click(function (e) {   // Mostramos la parte 3 y ocultamos la 2
        $('#part2').hide();
        $('#part3').show();
    });

    $('#btnPtV1').click(function (e) {  // Mostramos la parte 1 y ocultamos la 2
        $('#part2').hide();
        $('#part1').show();
    });

    $('#formEditarPeluquerosPeluqueria').submit(function (e) {  // Si todo valida mandamos el formulario
        e.preventDefault();
        if (validar()) this.submit();
    });
});