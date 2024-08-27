$(document).ready(function () {
    function valNombre() { // Validamos el campo Nombre
        let txtNombre = $('#txtNombre').val();
        let errorNombre = $('.text-danger').eq(0);
        if (txtNombre === undefined || txtNombre.trim() === '') {
            errorNombre.html('<h4>* El nombre es obligatorio.</h4>');
            return false;
        }
        errorNombre.text('');
        return true;
    }

    function valPrecio() { // Validamos campos
        let txtPrecio = $('#txtPrecio').val();
        let errorPrecio = $('.text-danger').eq(1);
        let validaPrecio = /^\d+(,\d{1,2})?$/;  // Creo una expresion regular para validar el campo

        if (txtPrecio.trim() === '' && txtPrecio.includes('.')) {
            errorPrecio.html('<h4>* El campo del precio no puede estar vacío o está mal introducido el precio, si usaste un punto, pon una coma.</h4>');
            return false;
        }

        if (!validaPrecio.test(txtPrecio)) {
            errorPrecio.html('<h4>* El precio debe tener una coma como separador</h4>');
            return false;
        }

        errorPrecio.text('');
        return true;
    }

    function valCategoria() { // Validamos campos
        let txtCategoria = $('select[name="ser_cat_id_fk"]').val();
        let errorCategoria = $('.text-danger').eq(2);
        if (txtCategoria === undefined || txtCategoria === '') {
            errorCategoria.html('<h4>* Debe seleccionar una categoría.</h4>');
            return false;
        }
        errorCategoria.text('');
        return true;
    }

    function validar() { // Validamos todos los campos
        let txtNombre = valNombre();
        let txtPrecio = valPrecio();
        let txtCategoria = valCategoria();
        return txtNombre && txtPrecio && txtCategoria;
    }

    $('#formRegistro').submit(function (e) { // Si todo valida, enviamos el formulario
        e.preventDefault();
        if (validar()) this.submit();
    });
});