using Newtonsoft.Json;
using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.Repository.RepositoryUsuarios;
using MyReserve.Models.TablasBBDD.Usuarios;

namespace MyReserve.Controllers {
    public class FormulariosController : Controller {
        private readonly IFormulario _formularioRepository;
        public FormulariosController(IFormulario formularioRepository) {
            _formularioRepository = formularioRepository;
        }
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
                return RedirectToAction("Index", "Libro", usuario);
            }
        }

        public void serializarUsuario(Usuarios usuario) {
            string json = JsonConvert.SerializeObject(usuario);
            HttpContext.Session.SetString("UsuarioActual", json);
        }

        public Usuarios deserializarUsuario() {
            Usuarios usuario = new Usuarios();
            string json = HttpContext.Session.GetString("UsuarioActual");
            usuario = JsonConvert.DeserializeObject<Usuarios>(json);
            return usuario;
        }

    }
}
