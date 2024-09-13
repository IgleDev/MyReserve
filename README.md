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
