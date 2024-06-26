$(document).ready(function () {

    $('#part2').hide();
    $('#part3').hide();

    function valNombre() {
        let txtNombre = $('#txtNombre').val();
        let errorNombre = $('.text-danger').eq(0);
        if (txtNombre === undefined || txtNombre === '') {
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

    function valCiudad() {
        let txtCiudad = $('#txtCiudad').val();
        let errorCiudad = $('.text-danger').eq(3);
        if (txtCiudad === undefined || txtCiudad === '') {
            errorCiudad.html('<h4>* Error al escribir la experiencia</h4>');
            return false
        }
        errorCiudad.text('');
        return true;
    }

    function valPais() {
        let txtPais = $('#txtPais').val();
        let errorPais = $('.text-danger').eq(4);
        if (txtPais === undefined || txtPais === '') {
            errorPais.html('<h4>* Error al escribir tu instagram</h4>');
            return false
        }
        errorPais.text('');
        return true;
    }

    function valTelefono() {
        let txtTelefono = $('#txtTelefono').val();
        let errorTelefono = $('.text-danger').eq(5);
        if (txtTelefono === undefined || txtTelefono === '') {
            errorTelefono.html('<h4>* Error al escribir el nombre de la peluquería</h4>');
            return false
        }
        errorTelefono.text('');
        return true;
    }

    function valGP() {
        let txtGP = $('#txtGP').val();
        let errorGP = $('.text-danger').eq(6);
        if (txtGP === undefined || txtGP === '') {
            errorGP.html('<h4>* Error al escribir el grupo de peluquerías</h4>');
            return false
        }
        errorGP.text('');
        return true;
    }

    function validar() {
        let txtNombre = valNombre();
        let txtCorreo = valCorreo();
        let txtContrasenha = valContrasenha();
        let txtExperiencia = valCiudad();
        let txtRRSS = valPais();
        let txtNombrePeluqueria = valTelefono();
        let txtGP = valGP();
        if (txtNombre && txtCorreo && txtContrasenha && txtExperiencia &&
            txtRRSS && txtNombrePeluqueria && txtGP) return true;
    }

    $('#btnPt1').click(function (e) {
        $('#part1').hide();
        $('#part2').show();
    });

    $('#btnPt2').click(function (e) {
        $('#part2').hide();
        $('#part3').show();
    });

    $('#btnPtV1').click(function (e) {
        $('#part2').hide();
        $('#part1').show();
    });

    $('#btnPt3').click(function (e) {
        $('#part3').hide();
        $('#part2').show();
    });

    $('#formRegistroPeluquerias').submit(function (e) {
        e.preventDefault();
        if (validar()) this.submit();
    });
});