$(document).ready(function () {

    $('#part2').hide();

    function valNombre() {
        let txtNombre = $('#txtNombre').val();
        let errorNombre = $('.text-danger').eq(0);
        if (txtNombre === undefined || txtNombre === '' || txtNombre.includes(' ')) {
            errorNombre.html('<h4>* Error al escribir el nombre</h4>');
            return false
        }
        errorNombre.text('');
        return true;
    }

    function valCorreo() {
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

    function valContrasenha() {
        let txtContrasenha = $('#txtContrasenha').val();
        let errorContrasenha = $('.text-danger').eq(2);
        if (txtContrasenha === undefined || txtContrasenha === '' || txtContrasenha.includes(' ')) {
            errorContrasenha.html('<h4>* Error al escribir la contraseña</h4>');
            return false
        }
        errorContrasenha.text('');
        return true;
    }
    function valPais() {
        let txtPais = $('#txtPais').val();
        let errorPais = $('.text-danger').eq(3);
        if (txtPais === undefined || txtPais === '' || txtPais.includes(' ')) {
            errorPais.html('<h4>* Error al escribir el País</h4>');
            return false
        }
        errorPais.text('');
        return true;
    }

    function valCiudad() {
        let txtCiudad = $('#txtCiudad').val();
        let errorCiudad = $('.text-danger').eq(4);
        if (txtCiudad === undefined || txtCiudad === '' || txtCiudad.includes(' ')) {
            errorCiudad.html('<h4>* Error al escribir la ciudad</h4>');
            return false
        }
        errorCiudad.text('');
        return true;
    }

    function validar() {
        let txtNombre = valNombre();
        let txtCorreo = valCorreo();
        let txtContrasenha = valContrasenha();
        let txtPais = valPais();
        let txtCiudad = valCiudad();
        if (txtNombre && txtCorreo && txtContrasenha && txtPais && txtCiudad) return true;
    }

    $('#btnPtV1').click(function (e) {
        $('#part1').hide();
        $('#part2').show();
    });

    $('#btnPt3').click(function (e) {
        $('#part2').hide();
        $('#part1').show();
    });

    $('#formRegistro').submit(function (e) {
        e.preventDefault();
        if (validar()) {
            this.submit();
        }
    });
});