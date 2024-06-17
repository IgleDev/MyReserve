using Newtonsoft.Json;
using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.Repository.RepositoryUsuarios;
using MyReserve.Models.TablasBBDD.Usuarios;
using MyReserve.Models.TablasBBDD.Peluqueros;

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
                return RedirectToAction("Index", "Peluqueria", usuario);
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

        // Login & Registro de Grupos/Peluquerías ->

        public IActionResult LoginAdmin() {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> LoginAdmin(string usu_correo_electronico, string usu_contrasenha) {
            var usuario = await _formularioRepository.Login(usu_correo_electronico, usu_contrasenha);
            if(usuario == null) {
                return View("Login");
            } else {
                serializarUsuario(usuario);
                return RedirectToAction("Index", "Libro", usuario);
            }
        }

        public void serializarUsuario(Usuarios usuario) {
            string json = JsonConvert.SerializeObject(usuario);
            HttpContext.Session.SetString("UsuarioActual", json);
        }

        public void serializarPeluquero(Peluqueros peluquero) {
            string json = JsonConvert.SerializeObject(peluquero);
            HttpContext.Session.SetString("PeluqueroActual", json);
        }

        public Usuarios deserializarUsuario() {
            Usuarios usuario = new Usuarios();
            string json = HttpContext.Session.GetString("UsuarioActual");
            usuario = JsonConvert.DeserializeObject<Usuarios>(json);
            return usuario;
        }

    }
}
