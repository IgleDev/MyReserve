using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis.Scripting;
using MyReserve.Models.Repository.RepositoryUsuario;
using MyReserve.Models.Repository.RepositoryUsuarios;
using MyReserve.Models.TablasBBDD.Usuarios;
using Newtonsoft.Json;

namespace MyReserve.Controllers {
    public class InfoUsuariosController : Controller {
        private readonly IInfoUsuarios _usuariosRepository;
        public InfoUsuariosController(IInfoUsuarios usuariosRepository) {
            _usuariosRepository = usuariosRepository;
        }

        [HttpGet]
        public IActionResult Portal() {
            Usuarios usuariosActual = deserializarUsuario();
            var paises = _usuariosRepository.getPaises();

            if(usuariosActual == null) {
                return RedirectToAction("Index", "Home");
            }
            usuariosActual = new Usuarios {
                usu_id = usuariosActual.usu_id,
                usu_nombre = usuariosActual.usu_nombre,
                usu_correo_electronico = usuariosActual.usu_correo_electronico,
                usu_contrasenha = usuariosActual.usu_contrasenha,
                listaPaises = paises
            };
            serializarUsuario(usuariosActual);
            return View(usuariosActual);
        }

        public IActionResult Editar() {
            Usuarios usuariosActual = deserializarUsuario();
            return View(usuariosActual);
        }

        [HttpPost]
        public async Task<IActionResult> EditarUsuario(Usuarios usuarios) {
            await _usuariosRepository.Editar(usuarios);
            serializarUsuario(usuarios);
            return RedirectToAction("Portal");
        }

        [HttpPost]
        public async Task<IActionResult> Eliminar(int usu_id) {
            await _usuariosRepository.Eliminar(usu_id);
            deserializarUsuario();
            return RedirectToAction("Index", "Home");
        }

        [HttpGet]
        public async Task<IActionResult> getRegionesPais(string pai_nombre) {
            if(string.IsNullOrEmpty(pai_nombre)) {
                return Json("No hay parametros disponibles");
            }

            var regiones = await _usuariosRepository.getRegionesPais(pai_nombre);
            return Json(regiones);
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
