﻿using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.HelpersTablasBBDD.InfoPeluqueriaModel;
using MyReserve.Models.Repository.RepositoryUsuario;
using MyReserve.Models.TablasBBDD.Cita;
using MyReserve.Models.TablasBBDD.Horarios;
using MyReserve.Models.TablasBBDD.Servicios;
using MyReserve.Models.TablasBBDD.Usuarios;
using Newtonsoft.Json;
using System.Globalization;

namespace MyReserve.Controllers {
    public class InfoUsuariosController : Controller {
        private readonly IInfoUsuarios _usuariosRepository;
        public InfoUsuariosController(IInfoUsuarios usuariosRepository) {
            _usuariosRepository = usuariosRepository;
        }

        [HttpGet]
        public IActionResult Portal() {
            Usuarios usuariosActual = deserializarUsuario(); // Recogemos el usuario
            var errorVista = returnHome(usuariosActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            var paises = _usuariosRepository.getPaises();   // Recogemos los países

            if(usuariosActual.listaPeluqueria == null) { // Si la lista es null que no las cree por defecto
                usuariosActual.listaPeluqueria = new List<MyReserve.Models.TablasBBDD.Peluqueria.Peluqueria>();
            } 

            usuariosActual = new Usuarios { // Creamos el usuario Actual
                usu_id = usuariosActual.usu_id,
                usu_nombre = usuariosActual.usu_nombre,
                usu_correo_electronico = usuariosActual.usu_correo_electronico,
                usu_contrasenha = usuariosActual.usu_contrasenha,
                listaPaises = paises
            };

            serializarUsuario(usuariosActual);  // Lo guardamos en la sesión
            return View(usuariosActual);    // Retornamos la vista
        }

        public IActionResult Editar() {
            Usuarios usuariosActual = deserializarUsuario();    // Recuperamos el usuario
            var errorVista = returnHome(usuariosActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }
            return View(usuariosActual);    // Mostramos el usuario 
        }

        public async Task<IActionResult> InfoPeluquerias(int pelu_id) {
            Usuarios usuariosActual = deserializarUsuario(); // Recuperamos el usuario
            var errorVista = returnHome(usuariosActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            var peluqueria = await _usuariosRepository.getPeluqueriaID(pelu_id);    // Recogemos la peluqueria según el id que pasamos
            var peluqueros = await _usuariosRepository.getPeluquerosPeluqueriaID(pelu_id);  // Recogemos los peluqueros de la peluqueria
            var servicios = await _usuariosRepository.getServiciosPeluqueria(pelu_id);
            var horarios = await _usuariosRepository.getHorariosPeluqueria(pelu_id);

            ViewBag.usuariosActual = usuariosActual.usu_nombre;
            ViewBag.usuariosActualID = usuariosActual.usu_id;
            peluqueria.Servicios = servicios?.ToList() ?? new List<Servicios>();
            peluqueria.Horarios = horarios?.ToList() ?? new List<Horarios>();

            var peluInfo = new InfoPeluqueriaModel {    // Creamos la peluqueria con la información que le pasamos
                peluqueriaInfo = peluqueria,
                usu_id = usuariosActual.usu_id,
                peluquerosInfo = peluqueros ?? new List<MyReserve.Models.TablasBBDD.Peluqueros.Peluqueros>(),
            };

            return View(peluInfo);  // Retornamos la vista
        }

        [HttpPost]
        public async Task<IActionResult> EditarUsuario(Usuarios usuarios) {
            var usuarioCorreo = deserializarUsuario();

            if(usuarioCorreo.usu_correo_electronico != usuarios.usu_correo_electronico) {
                var correo = await _usuariosRepository.comprobarCorreoUsuario(usuarios.usu_correo_electronico);
                if(correo) {
                    ModelState.AddModelError("usu_correo_electronico", "El correo electrónico ya está en uso.");
                    return View("Editar", usuarios);
                }
            }

            await _usuariosRepository.Editar(usuarios); // Pasamos el usuario a modificar
            serializarUsuario(usuarios);    // Guardamos el usuario modificado en la sesión
            return RedirectToAction("Portal");  //  Redirigimos al usuario
        }

        [HttpPost]
        public async Task<IActionResult> Eliminar(int usu_id) {
            await _usuariosRepository.Eliminar(usu_id); // Pasamos el id del usuario
            deserializarUsuario();  // Recuperamos la sesión para indicar que el usuario está borrado
            return RedirectToAction("Index", "Home"); // Redirigimos al usuario a la página de inicio
        }

        [HttpGet]
        public async Task<IActionResult> getRegionesPais(string pai_nombre) {
            if(string.IsNullOrEmpty(pai_nombre)) {
                return Json("No hay parametros disponibles");
            }
            var regiones = await _usuariosRepository.getRegionesPais(pai_nombre);   // Recuperamos las regiones 
            return Json(regiones);  // Las devolvemos como JSON para ser tratadas en el archivo de JavaScript
        }

        [HttpGet]
        public async Task<IActionResult> getCitaUsuario(int usu_id, DateTime fechaCita) {
            bool cita = await _usuariosRepository.comprobarCitaUsuario(usu_id, fechaCita);

            if(cita) {
                return Json(new { success = false, message = "Ya tienes un cita este día" });
            }

            return Json(new { success = true });
        }

        [HttpGet]
        public async Task<IActionResult> BuscarPeluqueriaCerca(string pelu_pais, string pelu_region, string pelu_ciudad) {
            var peluquerias = await _usuariosRepository.getPeluqueriasFiltro(pelu_pais, pelu_region, pelu_ciudad);
            var usuariosActual = deserializarUsuario(); // Recuperamos el usuario
            var errorVista = returnHome(usuariosActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            usuariosActual.listaPeluqueria = peluquerias;   // Recuperamos las peluquerias y los paises
            usuariosActual.listaPaises = _usuariosRepository.getPaises();

            serializarUsuario(usuariosActual);  // Almacenamos el usuario de nuevo
            return View("Portal", usuariosActual);  // Devolvemos la vista con el filtro ya hecho
        }

        [HttpPost]
        public async Task<IActionResult> ReservarCita(int pelu_id, int usu_id, int peluquerosPeluqueria, int horariosPeluqueria, string fechaCita, int[] serviciosPeluqueria) {
            var usuariosActual = deserializarUsuario(); // Recuperamos el usuario actual
            var errorVista = returnHome(usuariosActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            var peluqueria = await _usuariosRepository.getPeluqueriaID(pelu_id);    // Recuperamos la peluquería

            //Pasamos la fecha en un formato que soporte la BBDD
            if(!DateTime.TryParseExact(fechaCita, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime citaFecha)) {
                return View("InfoPeluquerias", pelu_id);    // Si falla redirigimos de nuevo a la página
            }

            // Creamos la cita
            var cita = new Cita {
                cita_usu_id_fk = usuariosActual.usu_id,
                cita_pelu_id_fk = peluqueria.pelu_id,
                cita_pel_id_fk = peluquerosPeluqueria,
                cita_hora_id_fk = horariosPeluqueria,
                cita_fecha = citaFecha,
                servicios = serviciosPeluqueria?.ToList() ?? new List<int>()
            };

            var cita_id = await _usuariosRepository.GuardarCita(cita);  // Guardamos la cita y obtienemos su ID

            if(cita_id <= 0) {
                return View("InfoPeluquerias", pelu_id);    // Si falla redirigimos de vuelta a la zona de citas
            }

            if(cita.servicios.Any()) {
                await _usuariosRepository.GuardarCitasServicios(cita_id, cita.servicios);   // Guardamos los servicios de la cita del usuario
            }

            return RedirectToAction("Portal");  // Redirigimos al portal
        }

        public async Task<IActionResult> VerCitas(int usu_id) {
            var usuarioActual = deserializarUsuario();  // Recuperamos los usuarios
            var errorVista = returnHome(usuarioActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            ViewBag.usu_id = usuarioActual.usu_id;   // Pasamos el ID mediante un ViewBag
            ViewBag.usuNombre = usuarioActual.usu_nombre;   // Pasamos el nombre mediante un ViewBag
            var citasUsuario = await _usuariosRepository.getCitasUsuario(usu_id);   // Recuperamos las citas del usuario gracias al ID
            return View(citasUsuario.ToList()); // // Mandamos la vista convertida en un ToList();
        }

        [HttpPost]
        public async Task<IActionResult> EliminarCitas(int cita_id) {
            await _usuariosRepository.EliminarCita(cita_id);    // Eliminamos la cita gracias a su propio ID
            Usuarios usuariosActual = deserializarUsuario(); // Recogemos el usuario
            var errorVista = returnHome(usuariosActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            var paises = _usuariosRepository.getPaises();   // Recogemos los países

            if(usuariosActual.listaPeluqueria == null) { // Si la lista es null que no las cree por defecto
                usuariosActual.listaPeluqueria = new List<MyReserve.Models.TablasBBDD.Peluqueria.Peluqueria>();
            }

            usuariosActual = new Usuarios { // Creamos el usuario Actual
                usu_id = usuariosActual.usu_id,
                usu_nombre = usuariosActual.usu_nombre,
                usu_correo_electronico = usuariosActual.usu_correo_electronico,
                usu_contrasenha = usuariosActual.usu_contrasenha,
                listaPaises = paises
            };

            serializarUsuario(usuariosActual);  // Lo guardamos en la sesión
            return View("Portal", usuariosActual);
        }

        [HttpGet]
        public async Task<IActionResult> getHorariosDisponibles(int pel_id, DateTime fechaCita) {
            // Recuperamos los horarios disponibles segun la fecha.if (!DateTime.TryParse(fechaCita, out DateTime fechaCitaDate))
            var horarios = await _usuariosRepository.getHorariosDisponibles(pel_id, fechaCita);
            return Json(horarios);  // Devolvemos los horarios en formato JSON.
        }

        public void serializarUsuario(Usuarios usuario) {
            string json = JsonConvert.SerializeObject(usuario); // Transformamos el usuario en json
            HttpContext.Session.SetString("UsuarioActual", json);   //  Guardamos el usuario en sesión
        }

        public Usuarios deserializarUsuario() {
            Usuarios usuario = new Usuarios();  // Creamos un usuario
            string json = HttpContext.Session.GetString("UsuarioActual");   // Guardamos el usuario de la sesion en un json
            
            if(string.IsNullOrEmpty(json)) {
                return null;
            }

            usuario = JsonConvert.DeserializeObject<Usuarios>(json);    // Transformamos a Usuario el json
            return usuario; // Devolvemos el usuario
        }

        private IActionResult returnHome(object entidad) {  // Método privado para redireccionar si la entidad es null
            if(entidad == null) {
                return RedirectToAction("Index", "Home");
            }

            return null;
        }
    }
}
