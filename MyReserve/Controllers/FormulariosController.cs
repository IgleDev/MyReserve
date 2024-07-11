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
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login(string usu_correo_electronico, string usu_contrasenha) {
            var usuario = await _formularioRepository.Login(usu_correo_electronico, usu_contrasenha);
            if(usuario == null) {
                return View("Login");
            } else {
                serializarUsuario(usuario);
                return RedirectToAction("Portal", "InfoUsuarios", usuario);
            }
        }

        public IActionResult Registro() {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Registro(Usuarios usuario) {
            await _formularioRepository.RegistroUsuario(usuario);
            return View("Login", usuario);
        }

        // Login & Registro de Peluqueros ->

        public IActionResult LoginPeluqueros() {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> LoginPeluqueros(string pel_correo_electronico, string pel_contrasenha) {
            var peluquero = await _formularioRepository.LoginPeluquero(pel_correo_electronico, pel_contrasenha);
            if(peluquero == null) {
                return View("LoginPeluqueros");
            } else {
                serializarPeluquero(peluquero);
                return RedirectToAction("Portal", "Peluqueros", peluquero);
            }
        }

        public IActionResult RegistroPeluqueros() {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> RegistroPeluqueros(Peluqueros peluqueros) {
            if(!ModelState.IsValid) {
                return View(peluqueros);
            }

            int peluqueriaId = await _formularioRepository.PeluqueriaIDNombre(peluqueros.pel_pelu_id_fk);
            int grupoId = await _formularioRepository.GrupoIdNombre(peluqueros.pel_grupo_id_fk);

            var peluquero = new Peluqueros {
                pel_nombre = peluqueros.pel_nombre,
                pel_correo_electronico = peluqueros.pel_correo_electronico,
                pel_contrasenha = peluqueros.pel_contrasenha,
                pel_experiencia = peluqueros.pel_experiencia,
                pel_instagram = peluqueros.pel_instagram,
                pel_pelu_id_fk = peluqueriaId.ToString(),
                pel_grupo_id_fk = grupoId.ToString()
            };

            await _formularioRepository.RegistroPeluqueros(peluquero);

            return RedirectToAction("Portal", "Peluquerias");
        }

        // Login & Registro de Grupos/Peluquerías ->

        public IActionResult LoginPeluqueria() {
            return View();
        }

        public async Task<IActionResult> LoginPeluquerias(string pelu_correo_electronico, string pelu_contrasenha) {
            var peluqueria = await _formularioRepository.LoginPeluqueria(pelu_correo_electronico, pelu_contrasenha);
            if(peluqueria == null) {
                return View("LoginPeluqueria");
            } else {
                serializarPeluqueria(peluqueria);
                return RedirectToAction("Portal", "Peluquerias", peluqueria);
            }
        }

        public IActionResult LoginGrupo() {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> LoginGrupo(string gp_correo_electronico, string gp_contrasenha) {
            var gp = await _formularioRepository.LoginGrupo(gp_correo_electronico, gp_contrasenha);
            if(gp == null) {
                return View("LoginGrupo");
            } else {
                serializarGrupo(gp);
                return RedirectToAction("Portal", "GrupoPeluqueria", gp);
            }
        }

        [HttpGet]
        public async Task<IActionResult> RegistroPeluqueria() {
            GrupoPeluqueria grupoActual = deserializarGrupo();
            var paises = await _formularioRepository.getPaises();

            var peluqueria = new Peluqueria {
                grupoPeluqueria = grupoActual,
                pelu_gp_id_fk = grupoActual.gp_nombre,
                listaPaises = paises
            };

            return View(peluqueria);
        }

        [HttpGet]
        public async Task<IActionResult> getRegionesPais(string pai_nombre) {
                if(string.IsNullOrEmpty(pai_nombre)) {
                    return Json("No hay parametros disponibles");
                }

                var regiones = await _formularioRepository.getRegionesPais(pai_nombre);
                return Json(regiones);
        }


        [HttpPost]
        public async Task<IActionResult> RegistroPeluqueria(Peluqueria peluqueria) {
            if(!ModelState.IsValid) {
                GrupoPeluqueria grupoActual = deserializarGrupo();
                peluqueria.pelu_gp_id_fk = grupoActual.gp_nombre;
            }

            int pelu_gp_id_fk = await _formularioRepository.GrupoIdNombre(peluqueria.pelu_gp_id_fk);

            var nuevaPeluqueria = new Peluqueria {
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

            await _formularioRepository.RegistroPeluqueria(nuevaPeluqueria);

            return RedirectToAction("Portal", "GrupoPeluqueria");
        }


        public IActionResult RegistroGrupo() {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> RegistroGrupos(GrupoPeluqueria grupo) {
            await _formularioRepository.RegistroGrupos(grupo);
            return View("LoginGrupo", grupo);
        }

        // Helpers

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