$(document).ready(function () {
    function valCorreo() {
        let validaEmail = new RegExp(/^(([^<>()\[\]\\.,;:\s@”]+(\.[^<>()\[\]\\.,;:\s@”]+)*)|(“.+”))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
        let txtCorreo = $('#txtCorreo').val();
        if (!validaEmail.test(txtCorreo)) {
            let errorCorreo = $('.text-danger').eq(0);
            errorCorreo.html('<h4>* Error en el correo electrónico</h4>');
            return false
        }
        errorCorreo.text('');
        return true;
    }

    function valContrasenha() {
        let txtContrasenha = $('#txtContrasenha').val();
        if (txtContrasenha === undefined || txtContrasenha === '' || txtContrasenha.includes(' ')) {
            let errorContrasenha = $('.text-danger').eq(1);
            errorContrasenha.html('<h4>* Error al escribir la contraseña</h4>');
            return false
        }
        errorContrasenha.text('');
        return true;
    }

    function validar() {
        let txtCorreo = valCorreo();
        let txtContrasenha = valContrasenha();
        if (txtCorreo && txtContrasenha) return true;
    }

    $('#formLogin').submit(function (e) {
        e.preventDefault();
        if (validar()) {
            console.log('todo bien');
            this.submit();
        }
    });
});