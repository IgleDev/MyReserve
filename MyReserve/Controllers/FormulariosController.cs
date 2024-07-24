using Newtonsoft.Json;
using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.Repository.RepositoryUsuarios;
using MyReserve.Models.TablasBBDD.Usuarios;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Peluqueria;
using Microsoft.AspNetCore.Mvc.Rendering;

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
                serializarUsuario(usuario); // Guardamos al usuario en sesion
                return RedirectToAction("Portal", "InfoUsuarios", usuario); // Redirigimos el usuario a su respectivo Portal
            }
        }

        public IActionResult Registro() {
            return View();  // Mostramos la vista del Registro
        }

        [HttpPost]
        public async Task<IActionResult> Registro(Usuarios usuario) {
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
            if(peluquero == null) {
                return View("LoginPeluqueros");
            } else {
                serializarPeluquero(peluquero); // Guardamos el peluquero en sesion
                return RedirectToAction("Portal", "Peluqueros", peluquero); // Lo redireccionamos a su portal
            }
        }

        public async Task<IActionResult> RegistroPeluqueros() {
            Peluqueria peluActual = deserializarPeluqueria();
            GrupoPeluqueria grupoActual = await _formularioRepository.getGrupoPeluqueriaPeluqueriaNombre(peluActual.pelu_id); // Asegúrate de tener este método implementado correctamente

            var peluquero = new Peluqueros {
                peluqueria = peluActual,
                pel_pelu_id_fk = peluActual.pelu_nombre,
                pel_grupo_id_fk = grupoActual.gp_nombre
            };

            return View(peluquero);
        }

        [HttpPost]
        public async Task<IActionResult> RegistroPeluqueros(Peluqueros peluqueros) {
            if(!ModelState.IsValid) {
                return View(peluqueros);
            }

            // Convertimos los nombres a IDs
            int peluqueriaId = await _formularioRepository.PeluqueriaIDNombre(peluqueros.pel_pelu_id_fk);
            int grupoId = await _formularioRepository.GrupoIdNombre(peluqueros.pel_grupo_id_fk);

            var nuevoPeluquero = new Peluqueros {
                pel_nombre = peluqueros.pel_nombre,
                pel_correo_electronico = peluqueros.pel_correo_electronico,
                pel_contrasenha = peluqueros.pel_contrasenha,
                pel_experiencia = peluqueros.pel_experiencia,
                pel_instagram = peluqueros.pel_instagram,
                pel_pelu_id_fk = peluqueriaId.ToString(), // Convertimos a string
                pel_grupo_id_fk = grupoId.ToString() // Convertimos a string
            };

            await _formularioRepository.RegistroPeluqueros(nuevoPeluquero);

            return RedirectToAction("Portal", "Peluquerias");
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
            await _formularioRepository.RegistroGrupos(grupo);  // Registramos el grupo en la BBDD
            return View("LoginGrupo", grupo);   // Redireccionamos el grupo
        }

        //Servicios
        public async Task<IActionResult> RegistroServicios() {
            Peluqueria peluActual = deserializarPeluqueria();
            ViewBag.peluNombre = peluActual.pelu_nombre;
            var servicios = await _formularioRepository.getServicios();
            return View(servicios);
        }

        [HttpPost]
        public async Task<IActionResult> GuardarServicios(int[] selectedServices) {
            Peluqueria peluActual = deserializarPeluqueria(); // Obtener la peluquería actual
            if(selectedServices == null || !selectedServices.Any()) {
                ModelState.AddModelError("", "No se han seleccionado servicios.");
                return View(); // O redirige a una página adecuada
            }

            foreach(var servicioId in selectedServices) {
                await _formularioRepository.GuardarServicios(peluActual.pelu_id, servicioId);
            }

            // Redirige o muestra un mensaje de éxito
            return RedirectToAction("Portal", "Peluquerias"); // O la acción que desees
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