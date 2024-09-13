# My Reserve

My Reserve es un proyecto diseñado para modernizar las peluquerías, reemplazando los
métodos tradicionales de gestión de las peluquerías por un nuevo sistema digitalizado, pero al mismo tiempo sencillo e intuitivo, para que cualquiera sea capaz de
utilizarlo. Los usuarios podrán reservar citas fácilmente y las peluquerías podrán optimizar la administración de sus servicios y horarios.

## Objetivo
El Objetivo es modernizar el sistema de gestión de reservas de citas en peluquerías mediante una plataforma web, mejorando la experiencia del usuario y promoviendo el crecimiento de la peluquería.

## Desarrollo

### Análisis
Trata las entidades de los datos y de como las propias entidades gestionan sus datos

### Diseño
La aplicación está hecha en un proyecto de .NET, en el cual separamos dos grandes grupos
El BackEnd y el FrontEnd.

- BackEnd: En cuanto al BackEnd, mostramos como está construida su base de datos.

      ### Tabla `Usuarios`
    
    | Parameter                | Type     | Description                                   |
    | :----------------------- | :------- | :-------------------------------------------- |
    | `usu_id`                 | `int`    | **Required**. ID del usuario (IDENTITY)       |
    | `usu_nombre`             | `string` | **Required**. Nombre del usuario              |
    | `usu_correo_electronico` | `string` | **Required & Unique**. Correo electrónico del   usuario |
    | `usu_contrasenha`        | `string` | **Required**. Contraseña del usuario          |
    
    ### Tabla `GrupoPeluqueria`
    
    | Parameter                  | Type     | Description                                   |
    | :------------------------- | :------- | :-------------------------------------------- |
    | `gp_id`                    | `int`    | **Required**. ID del grupo de peluquería  (IDENTITY) |
    | `gp_nombre`                | `string` | **Required**. Nombre del grupo de peluquería  |
    | `gp_correo_electronico`     | `string` | **Required & Unique**. Correo electrónico del    grupo |
    | `gp_contrasenha`            | `string` | **Required**. Contraseña del grupo               |
    
    ### Tabla `Peluqueria`
    
    | Parameter                  | Type     | Description                                   |
    | :------------------------- | :------- | :-------------------------------------------- |
    | `pelu_id`                  | `int`    | **Required**. ID de la peluquería (IDENTITY)  |
    | `pelu_nombre`              | `string` | **Required**. Nombre de la peluquería         |
    | `pelu_correo_electronico`  | `string` | **Required & Unique**. Correo electrónico de  la peluquería |
    | `pelu_contrasenha`         | `string` | **Required**. Contraseña de la peluquería     |
    | `pelu_pais`                | `string` | **Required**. País de la peluquería           |
    | `pelu_region`              | `string` | **Required**. Región de la peluquería         |
    | `pelu_ciudad`              | `string` | **Required**. Ciudad de la peluquería         |
    | `pelu_direccion`           | `string` | **Required**. Dirección de la peluquería      |
    | `pelu_telefono`            | `string` | **Required**. Teléfono de la peluquería       |
    | `pelu_gp_id_fk`            | `int`    | **Required**. FK del grupo al que pertenece   |
    
    ### Tabla `Peluquero`
    
    | Parameter                  | Type     | Description                                   |
    | :------------------------- | :------- | :-------------------------------------------- |
    | `pel_id`                   | `int`    | **Required**. ID del peluquero (IDENTITY)     |
    | `pel_nombre`               | `string` | **Required**. Nombre del peluquero            |
    | `pel_correo_electronico`   | `string` | **Required & Unique**. Correo electrónico del     peluquero |
    | `pel_contrasenha`          | `string` | **Required**. Contraseña del peluquero        |
    | `pel_descripcion`          | `string` | Descripción del peluquero                     |
    | `pel_experiencia`          | `int`    | **Required**. Años de experiencia del     peluquero |
    | `pel_instagram`            | `string` | Instagram del peluquero (opcional)            |
    | `pel_pelu_id_fk`           | `int`    | **Required**. FK de la peluquería a la que    pertenece |
    | `pel_grupo_id_fk`          | `int`    | FK del grupo de peluquería                    |
    
    ### Tabla `Categoria`
    
    | Parameter                  | Type     | Description                                   |
    | :------------------------- | :------- | :-------------------------------------------- |
    | `cat_id`                   | `int`    | **Required**. ID de la categoría              |
    | `cat_nombre`               | `string` | **Required**. Nombre de la categoría          |
    
    ### Tabla `Servicios`
    
    | Parameter                  | Type     | Description                                   |
    | :------------------------- | :------- | :-------------------------------------------- |
    | `ser_id`                   | `int`    | **Required**. ID del servicio (IDENTITY)      |
    | `ser_nombre`               | `string` | **Required**. Nombre del servicio             |
    | `ser_precio`               | `int`    | **Required**. Precio del servicio             |
    | `ser_cat_id_fk`            | `int`    | **Required**. FK de la categoría              |
    | `ser_pelu_id_fk`           | `int`    | FK de la peluquería (opcional)                |
    
    ### Tabla `PeluqueriaServicios`
    
    | Parameter                  | Type     | Description                                   |
    | :------------------------- | :------- | :-------------------------------------------- |
    | `pelu_ser_pelu_id_fk`       | `int`    | **Required**. FK de la peluquería                |
    | `pelu_ser_ser_id_fk`        | `int`    | **Required**. FK del servicio                    |
    
    ### Tabla `Horarios`
    
    | Parameter                  | Type     | Description                                   |
    | :------------------------- | :------- | :-------------------------------------------- |
    | `hora_id`                  | `int`    | **Required**. ID del horario                  |
    | `hora_fecha`               | `time`   | **Required**. Hora del horario                |
    
    ### Tabla `PeluqueriaHorarios`
    
    | Parameter                  | Type     | Description                                   |
    | :------------------------- | :------- | :-------------------------------------------- |
    | `pelu_hora_pelu_id_fk`      | `int`    | **Required**. FK de la peluquería                |
    | `pelu_hora_hora_id_fk`      | `int`    | **Required**. FK del horario                     |
    | `hora_reservado`            | `int`    | Indica si la hora está reservada                 |
    
    ### Tabla `Citas`
    
    | Parameter                  | Type     | Description                                   |
    | :------------------------- | :------- | :-------------------------------------------- |
    | `cita_id`                  | `int`    | **Required**. ID de la cita (IDENTITY)        |
    | `cita_usu_id_fk`           | `int`    | **Required**. FK del usuario                  |
    | `cita_pel_id_fk`           | `int`    | **Required**. FK del peluquero                |
    | `cita_pelu_id_fk`          | `int`    | **Required**. FK de la peluquería             |
    | `cita_hora_id_fk`          | `int`    | **Required**. FK del horario                  |
    | `cita_fecha`               | `date`   | **Required**. Fecha de la cita                |
    
    ### Tabla `CitasServicios`
    
    | Parameter                  | Type     | Description                                   |
    | :------------------------- | :------- | :-------------------------------------------- |
    | `citas_ser_cita_id_fk`      | `int`    | **Required**. FK de la cita                      |
    | `citas_ser_ser_id`          | `int`    | **Required**. FK del servicio                    |
    
    ### Tabla `Paises`
    
    | Parameter                  | Type     | Description                                   |
    | :------------------------- | :------- | :-------------------------------------------- |
    | `pai_id`                   | `int`    | **Required**. ID del país                     |
    | `pai_nombre`               | `string` | **Required**. Nombre del país                 |
    
    ### Tabla `Region`
    
    | Parameter                  | Type     | Description                                   |
    | :------------------------- | :------- | :-------------------------------------------- |
    | `reg_id`                   | `int`    | **Required**. ID de la región                 |
    | `reg_pai_id_fk`            | `int`    | **Required**. FK del país                     |
    | `reg_nombre`               | `string` | **Required**. Nombre de la región             |

- FrontEnd: En cuanto al FrontEnd, mostramos las plantillas, como de estructurada está la web y como tratamos los datos.

### Implementación
- BackEnd: Es la implementación de como conectamos nuestro aplicación web con la base de datos, relacionandolas así gestionando los datos.
- FrontEnd: Mostramos la información que recuperamos del BackEnd en una vista.

### Pruebas
- BackEnd: Se implementan validaciones para controlar errores de tipo de dato incorrecto, redirigir a una página principal si el usuario no tiene permisos, y mostrar errores en peticiones no permitidas. Para eliminar entidades relacionadas se usan queries que garantizan la eliminación de las entidades. También he convertido datos a formato JSON para manejarlos adecuadamente en peticiones AJAX y devolverlos correctamente a las vistas.
- FrontEnd: Se utiliza JQuery en todos los formularios para mejorar el rendimiento y realizar validaciones previas, mostrando mensajes de error informativos. Las vistas son responsive, adaptándose a cualquier dispositivo. Se usa la librería Flatpickr para validar fechas, impidiendo la selección de domingos o fechas anteriores al día actual. Además, al reservar una cita, si el usuario ya tiene una cita en la fecha seleccionada, se muestra un aviso y no se permite añadir otra cita.
## Herramientas

**Client:** HTML, CSS3, JavaScript, JQuery, Bootstrap5

**Server:** .NET, C#

## Ayuda

Cualquier pregunta adri.iglesias.fernandez@gmail.com.

![Logo](https://github.com/IgleDev/MyReserve/blob/main/MyReserve/wwwroot/img/layout/logoreadme.png?raw=true)
[@IgleDev](https://github.com/IgleDev)
