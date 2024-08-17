using Newtonsoft.Json;
using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.Repository.RepositoryUsuarios;
using MyReserve.Models.TablasBBDD.Usuarios;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Servicios;

namespace MyReserve.Controllers {
    public class FormulariosController : Controller {
        private readonly IFormulario _formularioRepository;
        public FormulariosController(IFormulario formularioRepository) {
            _formularioRepository = formularioRepository;
        }

        // Login & Registro de Usuarios ->

        public IActionResult Login() {
            return View();  // Mostramos la vista del Login
        }

        [HttpPost]
        public async Task<IActionResult> Login(string usu_correo_electronico, string usu_contrasenha) {
            var usuario = await _formularioRepository.Login(usu_correo_electronico, usu_contrasenha); // Pasamos el correo y contraseña del usuario
            if(usuario == null) {
                return View("Login");
            } else {
                serializarUsuario(usuario); // Guardamos al usuario
                return RedirectToAction("Portal", "InfoUsuarios"); // Redirigimos el usuario a su respectivo Portal
            }
        }

        public IActionResult Registro() {
            return View();  // Mostramos la vista del Registro
        }

        [HttpPost]
        public async Task<IActionResult> Registro(Usuarios usuario) {
            if(await _formularioRepository.comprobarCorreoUsuario(usuario.usu_correo_electronico)) {
                ModelState.AddModelError("usu_correo_electronico", "El correo electrónico ya está en uso.");
                return View(usuario);
            }
            await _formularioRepository.RegistroUsuario(usuario);   // Registramos el usuario que le pasamos en la BBDD
            return View("Login", usuario);  // Redirigimos al usuario al login
        }

        // Login & Registro de Peluqueros ->

        public IActionResult LoginPeluqueros() {
            return View();  // Mostramos la vista del Login de peluqueros
        }

        [HttpPost]
        public async Task<IActionResult> LoginPeluqueros(string pel_correo_electronico, string pel_contrasenha) {
            var peluquero = await _formularioRepository.LoginPeluquero(pel_correo_electronico, pel_contrasenha);    // Pasamos el correo y contraseña del peluquero
            if(peluquero == null) { // Si es null devolvemos la vista
                return View("LoginPeluqueros");
            } else {
                serializarPeluquero(peluquero); // Guardamos el peluquero
                return RedirectToAction("PeluqueroPortal", "Peluquerias", peluquero); // Lo redireccionamos a su portal
            }
        }

        public async Task<IActionResult> RegistroPeluqueros() {
            Peluqueria peluActual = deserializarPeluqueria();   // Recogemos la peluqueria
            GrupoPeluqueria grupoActual = await _formularioRepository.getGrupoPeluqueriaPeluqueriaNombre(peluActual.pelu_id); // Sacamos el grupo actual

            var peluquero = new Peluqueros {    // Creamos una peluqueria
                peluqueria = peluActual,
                pel_pelu_id_fk = peluActual.pelu_nombre,
                pel_grupo_id_fk = grupoActual.gp_nombre
            };

            return View(peluquero); // Devolvemos vista
        }

        [HttpPost]
        public async Task<IActionResult> RegistroPeluqueros(Peluqueros peluqueros) {
            if(await _formularioRepository.comprobarCorreoPeluquero(peluqueros.pel_correo_electronico)) {   // Comprobamos si el gmail esta en la BBDD
                ModelState.AddModelError("pel_correo_electronico", "El correo electrónico ya está en uso.");    // Mandamos mensaje de error
                return View(peluqueros);    // Retornamos vista
            }

            if(!ModelState.IsValid) {   // Si el modelo no vale retornamos la vista con la informacion del peluquero
                return View(peluqueros);
            }

            // Convertimos los nombres a IDs
            int peluqueriaId = await _formularioRepository.PeluqueriaIDNombre(peluqueros.pel_pelu_id_fk);
            int grupoId = await _formularioRepository.GrupoIdNombre(peluqueros.pel_grupo_id_fk);

            var nuevoPeluquero = new Peluqueros {   // Creamos el peluquero
                pel_nombre = peluqueros.pel_nombre,
                pel_correo_electronico = peluqueros.pel_correo_electronico,
                pel_contrasenha = peluqueros.pel_contrasenha,
                pel_experiencia = peluqueros.pel_experiencia,
                pel_instagram = peluqueros.pel_instagram,
                pel_pelu_id_fk = peluqueriaId.ToString(), // Convertimos a string
                pel_grupo_id_fk = grupoId.ToString() // Convertimos a string
            };

            await _formularioRepository.RegistroPeluqueros(nuevoPeluquero); // Registramos peluqueros

            return RedirectToAction("Portal", "Peluquerias");   // Redireccionamos la vista
        }

        // Login & Registro de Grupos/Peluquerías ->

        public IActionResult LoginPeluqueria() {
            return View();  // Mostramos la vista del login de la peluqueria
        }

        public async Task<IActionResult> LoginPeluquerias(string pelu_correo_electronico, string pelu_contrasenha) {
            var peluqueria = await _formularioRepository.LoginPeluqueria(pelu_correo_electronico, pelu_contrasenha);    // Pasamos el correo y contraseña de la peluqueria
            if(peluqueria == null) {
                return View("LoginPeluqueria");
            } else {
                serializarPeluqueria(peluqueria);   // Guardamos la peluquería en sesión
                return RedirectToAction("Portal", "Peluquerias", peluqueria);   // La redirigimos a su portal
            }
        }

        public IActionResult LoginGrupo() {
            return View();  // Mostramos la vista del Login del Gripo
        }

        [HttpPost]
        public async Task<IActionResult> LoginGrupo(string gp_correo_electronico, string gp_contrasenha) {
            var gp = await _formularioRepository.LoginGrupo(gp_correo_electronico, gp_contrasenha); // Pasamos el correo y contraseña del grupo
            if(gp == null) {
                return View("LoginGrupo");
            } else {
                serializarGrupo(gp);    // Guardamos el grupo
                return RedirectToAction("Portal", "GrupoPeluqueria", gp);   // Redireccionamos el grupo a su portal
            }
        }

        [HttpGet]
        public async Task<IActionResult> RegistroPeluqueria() {
            GrupoPeluqueria grupoActual = deserializarGrupo();  // Recuperamos el grupo
            var paises = await _formularioRepository.getPaises();   // Recuperamos los países

            var peluqueria = new Peluqueria {
                grupoPeluqueria = grupoActual,
                pelu_gp_id_fk = grupoActual.gp_nombre,
                listaPaises = paises    // Mandamos los paises de la BBDD
            };

            return View(peluqueria);    // Devolvemos la vista
        }

        [HttpGet]
        public async Task<IActionResult> getRegionesPais(string pai_nombre) {
                var regiones = await _formularioRepository.getRegionesPais(pai_nombre); // Recuperamos las regiones 
            return Json(regiones); // Las devolvemos como JSON para ser tratadas en el archivo de JavaScript
        }


        [HttpPost]
        public async Task<IActionResult> RegistroPeluqueria(Peluqueria peluqueria) {
            if(!ModelState.IsValid) {   // Comprobamos que el modelo sea válido
                GrupoPeluqueria grupoActual = deserializarGrupo();  // Recuperamos el grupo
                peluqueria.pelu_gp_id_fk = grupoActual.gp_nombre;   // Le pasamos el nombre del grupo
            }

            if(await _formularioRepository.comprobarCorreoPeluqueria(peluqueria.pelu_correo_electronico)) {
                GrupoPeluqueria grupoActual = deserializarGrupo();  // Recuperamos el grupo
                ModelState.AddModelError("pelu_correo_electronico", "El correo electrónico ya está en uso.");   // Mandamos el mensaje de error
                var paises = await _formularioRepository.getPaises();   // Recuperamos los países

                var peluqueriaError = new Peluqueria {  // Volvemos a crear la peluqueria
                    grupoPeluqueria = grupoActual,
                    pelu_gp_id_fk = grupoActual.gp_nombre,
                    listaPaises = paises    // Mandamos los paises de la BBDD
                };

                return View(peluqueriaError);    // Devolvemos la vista
            }


            int pelu_gp_id_fk = await _formularioRepository.GrupoIdNombre(peluqueria.pelu_gp_id_fk);    // Según el nombre del grupo nos devuelve su ID

            var nuevaPeluqueria = new Peluqueria {  // Creamos la peluqueria
                pelu_nombre = peluqueria.pelu_nombre,
                pelu_correo_electronico = peluqueria.pelu_correo_electronico,
                pelu_contrasenha = peluqueria.pelu_contrasenha,
                pelu_pais = peluqueria.pelu_pais,
                pelu_region = peluqueria.pelu_region,
                pelu_ciudad = peluqueria.pelu_ciudad,
                pelu_direccion = peluqueria.pelu_direccion,
                pelu_telefono = peluqueria.pelu_telefono,
                pelu_gp_id_fk = pelu_gp_id_fk.ToString()
            };

            await _formularioRepository.RegistroPeluqueria(nuevaPeluqueria);    // Registramos la peluqueria
            return RedirectToAction("Portal", "GrupoPeluqueria");   // Redireccionamos a su debido portal
        }


        public IActionResult RegistroGrupo() {
            return View();  // Mostramos la vista del Registro del Grupo
        }

        [HttpPost]
        public async Task<IActionResult> RegistroGrupos(GrupoPeluqueria grupo) {
            if(await _formularioRepository.comprobarCorreoGrupo(grupo.gp_correo_electronico)) { // Comprobamos que el gmail no se repita con uno de la BBDD
                ModelState.AddModelError("gp_correo_electronico", "El correo electrónico ya está en uso."); // Mandamos mensaje de error
                return View("RegistroGrupo", grupo);    // Devolvemos vista
            }
            await _formularioRepository.RegistroGrupos(grupo);  // Registramos el grupo en la BBDD
            return View("LoginGrupo", grupo);   // Redireccionamos el grupo
        }

        //Servicios

        public async Task<IActionResult> RegistroServicios() {
            Peluqueria peluActual = deserializarPeluqueria();   // Recogemos la peluqueria
            ViewBag.peluNombre = peluActual.pelu_nombre;    // Mandamos el nombre a través de un ViewBag
            ViewBag.peluID = peluActual.pelu_id;    // Mandamos el ID a través de un ViewBag
            var serviciosCrear = await _formularioRepository.getServicios(peluActual.pelu_id);    // Mandamos la lista de servicios disponibles
            return View(serviciosCrear);    // Mandamos la vista
        }

        [HttpPost]
        public async Task<IActionResult> GuardarServicios(int[] seleccionarServicios) {
            Peluqueria peluActual = deserializarPeluqueria(); // Obtener la peluquería actual
            if(seleccionarServicios == null || !seleccionarServicios.Any()) {   // Comprobamos si el array está vacio
                var serviciosCrear = await _formularioRepository.getServicios(peluActual.pelu_id);    // Si lo está mandamos los servicios de vuelta
                return View("RegistroServicios", serviciosCrear); // Mostramos la vista
            }

            foreach(var servicio in seleccionarServicios) {   // Por cada iteración guardamos el servicio
                await _formularioRepository.GuardarServicios(peluActual.pelu_id, servicio);   // Guardamos los servicios
            }

            return RedirectToAction("Portal", "Peluquerias"); // Redirrecionamos a la página del Portal
        }

        public async Task<IActionResult> EditarServicios() {
            Peluqueria peluActual = deserializarPeluqueria();   // Obtenemos la peluqueria
            ViewBag.pelu_id = peluActual.pelu_id;    // Pasamos el ID de la peluqueria
            ViewBag.peluNombre = peluActual.pelu_nombre;    // Pasamos el nombre de la peluqueria
            var serviciosTodos = await _formularioRepository.getServiciosPeluqueria(peluActual.pelu_id);    // Sacamos todos los servicios
            var serviciosAsociados = serviciosTodos.Where(ser => ser.ser_asociado == 1).ToList();   // Sacamos los asociados
            var serviciosDisponibles = serviciosTodos.Where(ser => ser.ser_asociado == 0).ToList(); // Sacamos los disponibles

            var pelu = new Servicios {  // Creamos los servicios
                ServiciosAsociados = serviciosAsociados,
                ServiciosDisponibles = serviciosDisponibles,
                ser_pelu_id_fk = peluActual.pelu_id.ToString()
            };

            return View(pelu);    // Retornamos la peluqueria
        }

        [HttpPost]
        public async Task<IActionResult> ActualizarServicios(int[] serviciosActuales) {
            Peluqueria peluActual = deserializarPeluqueria(); // Obtener la peluquería actual

            var pelu = new Servicios {
                ser_pelu_id_fk = peluActual.pelu_id.ToString(),
            };

            if(serviciosActuales == null || !serviciosActuales.Any()) {
                ViewBag.peluNombre = peluActual.pelu_nombre;
                // Redirigir a la misma página de edición en caso de error
                await _formularioRepository.borrarServiciosPeluqueria(peluActual.pelu_id);  // Borramos lo servicios
                pelu.ServiciosDisponibles = await _formularioRepository.getServiciosPeluqueria(peluActual.pelu_id);
                return View("EditarServicios", pelu);
            }

            await _formularioRepository.borrarServiciosPeluqueria(peluActual.pelu_id);  // Borramos lo servicios

            foreach(var ser_id in serviciosActuales) {  // Añadimos los servicios
                await _formularioRepository.GuardarServicios(peluActual.pelu_id, ser_id);
            }

            return RedirectToAction("Portal", "Peluquerias");   // Redireccionamos la vista
        }

        public async Task<IActionResult> RegistroHorarios() {
            Peluqueria peluActual = deserializarPeluqueria();   // Recogemos la peluqueria
            ViewBag.peluNombre = peluActual.pelu_nombre;    // Mandamos el nombre a través de un ViewBag
            var horariosCrear = await _formularioRepository.getHorarios();    // Mandamos la lista de servicios disponibles
            return View(horariosCrear);    // Mandamos la vista
        }

        [HttpPost]
        public async Task<IActionResult> GuardarHorarios(int[] seleccionarHorarios) {
            // Recuperamos la peluqueria actual
            Peluqueria peluActual = deserializarPeluqueria();

            if(seleccionarHorarios == null || !seleccionarHorarios.Any()) {
                // Si no se selecciona ningun horario, obtenemos los horarios de nuevo y mostramos la vista
                var horarios = await _formularioRepository.getHorarios();
                ViewBag.peluNombre = peluActual.pelu_nombre;    // Pasamos el nombre de la peluqueria
                return View("RegistroHorarios", horarios);  // Mandamos la vista
            }

            // Guardamos las horas seleccionadas
            foreach(var hora_id in seleccionarHorarios) {
                await _formularioRepository.GuardarHorarios(peluActual.pelu_id, hora_id);   // Guardamos los horarios
            }

            return RedirectToAction("Portal", "Peluquerias"); // Redirige a la página del portal
        }

        public async Task<IActionResult> EditarHorarios() {
            Peluqueria peluActual = deserializarPeluqueria();   // Recogemos la peluqueria
            ViewBag.peluNombre = peluActual.pelu_nombre;    // Mandamos el nombre a través de un ViewBag
            var horariosEditar = await _formularioRepository.getHorariosPeluqueria(peluActual.pelu_id);    // Mandamos la lista de servicios disponibles
            peluActual.Horarios = horariosEditar.ToList();  // Le pasamos los horarios a modo de lista
            return View(peluActual);    // Mandamos la vista
        }

        [HttpPost]
        public async Task<IActionResult> ActualizarHorarios(int[] horariosActuales) {
            Peluqueria peluActual = deserializarPeluqueria(); // Obtener la peluquería actual
            if(horariosActuales == null || !horariosActuales.Any()) {
                // Redirigir a la misma página de edición en caso de error
                await _formularioRepository.borrarHorariosPeluqueria(peluActual.pelu_id);
                var horariosPeluqueria = await _formularioRepository.getHorariosPeluqueria(peluActual.pelu_id); // Pasamos todo igual para que el usuario vea lo mismo
                peluActual.Horarios = horariosPeluqueria.ToList();  // Le pasamos los horarios a modo de lista
                return View("EditarHorarios", peluActual);  // Mandamos la vista
            }

            await _formularioRepository.borrarHorariosPeluqueria(peluActual.pelu_id);   // Borramos todos los horarios según la peluqueria que sea

            foreach(var hora_id in horariosActuales) {
                await _formularioRepository.GuardarHorarios(peluActual.pelu_id, hora_id);   // Volvemos a guardar los horarios
            }

            return RedirectToAction("Portal", "Peluquerias");   // Mandamos la vista
        }


        // Helper
        public void serializarUsuario(Usuarios usuario) {
            string json = JsonConvert.SerializeObject(usuario);
            HttpContext.Session.SetString("UsuarioActual", json);
        }

        public void serializarPeluquero(Peluqueros peluquero) {
            string json = JsonConvert.SerializeObject(peluquero);
            HttpContext.Session.SetString("PeluqueroActual", json);
        }

        public void serializarPeluqueria(Peluqueria peluqueria) {
            string json = JsonConvert.SerializeObject(peluqueria);
            HttpContext.Session.SetString("PeluqueriaActual", json);
        }

        public void serializarGrupo(GrupoPeluqueria grupo) {
            string json = JsonConvert.SerializeObject(grupo);
            HttpContext.Session.SetString("GrupoActual", json);
        }

        public Usuarios deserializarUsuario() {
            Usuarios usuario = new Usuarios();
            string json = HttpContext.Session.GetString("UsuarioActual");
            usuario = JsonConvert.DeserializeObject<Usuarios>(json);
            return usuario;
        }

        public Peluqueros deserializarPeluquero() {
            Peluqueros peluquero = new Peluqueros();
            string json = HttpContext.Session.GetString("PeluqueroActual");
            peluquero = JsonConvert.DeserializeObject<Peluqueros>(json);
            return peluquero;
        }

        public Peluqueria deserializarPeluqueria() {
            Peluqueria peluqueria = new Peluqueria();
            string json = HttpContext.Session.GetString("PeluqueriaActual");
            peluqueria = JsonConvert.DeserializeObject<Peluqueria>(json);
            return peluqueria;
        }

        public GrupoPeluqueria deserializarGrupo() {
            GrupoPeluqueria grupo = new GrupoPeluqueria();
            string json = HttpContext.Session.GetString("GrupoActual");
            grupo = JsonConvert.DeserializeObject<GrupoPeluqueria>(json);
            return grupo;
        }
    }
}