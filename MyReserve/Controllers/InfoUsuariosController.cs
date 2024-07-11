using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.Repository.RepositoryUsuario;
using MyReserve.Models.TablasBBDD.Usuarios;
using Newtonsoft.Json;

namespace MyReserve.Controllers {
    public class InfoUsuariosController : Controller {
        private readonly IInfoUsuarios _usuariosRepository;
        public InfoUsuariosController(IInfoUsuarios usuariosRepository) {
            _usuariosRepository = usuariosRepository;
        }
        public async Task<IActionResult> Portal() {
            Usuarios usuariosActual = deserializarUsuario();
            var paises = await _usuariosRepository.getPaises();

            if(usuariosActual == null) {
                return RedirectToAction("Index", "Home");
            }
            usuariosActual = new Usuarios {
                listaPaises = paises
            };
            serializarUsuario(usuariosActual);
            return View(usuariosActual);
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
