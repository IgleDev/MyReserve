$(document).ready(function () {
    function valCorreo() {
        let validaEmail = new RegExp(/^(([^<>()\[\]\\.,;:\s@”]+(\.[^<>()\[\]\\.,;:\s@”]+)*)|(“.+”))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/);
        let txtCorreo = $('#txtCorreo').val();
        if (!validaEmail.test(txtCorreo)) {
            let errorCorreo = $('#txtCorreo').siblings('span[data-valmsg-for="usu_correo_electronico"]');
            errorCorreo.text('Error en el correo electrónico');
            return false
        }
        $('#txtCorreo').siblings('span[data-valmsg-for="usu_correo_electronico"]').text('');
        return true;
    }

    function valContrasenha() {
        let txtContrasenha = $('#txtContrasenha').val();
        if (txtContrasenha === undefined || txtContrasenha === '' || txtContrasenha.includes(' ')) {
            let errorContrasenha = $('.text-danger').eq(1);
            errorContrasenha.text('Error al escribir la contraseña');
            return false
        }
        $('#txtContrasenha').text('');
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