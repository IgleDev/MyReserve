using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.HelpersTablasBBDD.InfoPeluqueriaModel;
using MyReserve.Models.Repository.RepositoryUsuario;
using MyReserve.Models.TablasBBDD.Peluqueros;
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
            Usuarios usuariosActual = deserializarUsuario(); // Recogemos el usuario
            var paises = _usuariosRepository.getPaises();   // Recogemos los países

            if(usuariosActual == null) {    // Comprobamos el usuario
                return RedirectToAction("Index", "Home");
            }

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
            return View(usuariosActual);    // Mostramos el usuario 
        }

        public async Task<IActionResult> InfoPeluquerias(int pelu_id) {
            Usuarios usuariosActual = deserializarUsuario(); // Recuperamos el usuario
            var peluqueria = await _usuariosRepository.getPeluqueriaID(pelu_id);    // Recogemos la peluqueria según el id que pasamos
            var peluqueros = await _usuariosRepository.getPeluquerosPeluqueriaID(pelu_id);

            var peluInfo = new InfoPeluqueriaModel {    // Creamos la peluqueria con la información que le pasamos
                peluqueriaInfo = peluqueria,
                peluqueroInfo = peluqueros,
                usu_nombre = usuariosActual.usu_nombre
            };

            return View(peluInfo);  // Retornamos la vista
        }

        [HttpPost]
        public async Task<IActionResult> EditarUsuario(Usuarios usuarios) {
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
        public async Task<IActionResult> BuscarPeluqueriaCerca(string pelu_pais, string pelu_region, string pelu_ciudad) {
            var peluquerias = await _usuariosRepository.getPeluqueriasFiltro(pelu_pais, pelu_region, pelu_ciudad);
            var usuariosActual = deserializarUsuario(); // Recuperamos el usuario

            usuariosActual.listaPeluqueria = peluquerias;   // Recuperamos las peluquerias y los paises
            usuariosActual.listaPaises = _usuariosRepository.getPaises();

            serializarUsuario(usuariosActual);  // Almacenamos el usuario de nuevo
            return View("Portal", usuariosActual);  // Devolvemos la vista con el filtro ya hecho
        }

        public void serializarUsuario(Usuarios usuario) {
            string json = JsonConvert.SerializeObject(usuario); // Transformamos el usuario en json
            HttpContext.Session.SetString("UsuarioActual", json);   //  Guardamos el usuario en sesión
        }

        public Usuarios deserializarUsuario() {
            Usuarios usuario = new Usuarios();  // Creamos un usuario
            string json = HttpContext.Session.GetString("UsuarioActual");   // Guardamos el usuario de la sesion en un json
            usuario = JsonConvert.DeserializeObject<Usuarios>(json);    // Transformamos a Usuario el json
            return usuario; // Devolvemos el usuario
        }
    }
}
