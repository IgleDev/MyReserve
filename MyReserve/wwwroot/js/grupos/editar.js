﻿$(document).ready(function () {

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

    function valCorreo() { // Validamos campos
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

    function valDireccion() { // Validamos campos
        let txtDireccion = $('#txtDireccion').val();
        let errorDireccion = $('.text-danger').eq(3);
        if (txtDireccion === undefined || txtDireccion === '') {
            errorDireccion.html('<h4>* Error al escribir la contraseña</h4>');
            return false
        }
        errorDireccion.text('');
        return true;
    }

    function valTelefono() { // Validamos campos
        let txtTel = $('#txtTel').val();
        let errorTel = $('.text-danger').eq(3);
        if (txtTel === undefined || txtTel === '') {
            errorTel.html('<h4>* Error al escribir la contraseña</h4>');
            return false
        }
        errorTel.text('');
        return true;
    }

    function validar() { // Validamos campos
        let txtNombre = valNombre();
        let txtCorreo = valCorreo();
        let txtContrasenha = valContrasenha();
        let txtDireccion = valContrasenha();
        let txtTel = valContrasenha();
        if (txtNombre && txtCorreo && txtContrasenha && txtDireccion && txtTel) return true;
    }

    $('#editarPeluqueria').submit(function (e) { // Si todo valida mandamos el formulario
        e.preventDefault();
        if (validar()) this.submit();
    });
});