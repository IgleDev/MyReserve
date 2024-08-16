using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.Repository.RepositoryGrupoPeluquerias;
using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Peluqueria;
using Newtonsoft.Json;

namespace MyReserve.Controllers {
    public class GrupoPeluqueriaController : Controller {
        private readonly IGrupoPeluquerias _grupoPeluqueriasRepository;
        public GrupoPeluqueriaController(IGrupoPeluquerias grupoPeluqueriasRepository) {
            _grupoPeluqueriasRepository = grupoPeluqueriasRepository;
        }

        public IActionResult Portal() {
            GrupoPeluqueria grupoActual = deserializarGrupo();  // Recuperamos el grupo
            var grupoPeluquerias = _grupoPeluqueriasRepository.GetPeluquerias(grupoActual); // Recuperamos las peluquerias del grupo
            grupoActual.peluquerias = grupoPeluquerias; // Añadimos las peluquerias a la lista del grupo
            serializarGrupo(grupoActual);   // Guardamos en sesión
            return View(grupoActual);  // Retornamos el grupo
        }

        public async Task<IActionResult> EditarPeluqueria(int pelu_id) {
            GrupoPeluqueria grupoActual = deserializarGrupo();  // Recuperamos el grupo
            ViewBag.grupoNombre = grupoActual.gp_nombre;    // Mandamos el nombre del grupo mediante un ViewBag
            var peluEditar = await _grupoPeluqueriasRepository.getPeluqueriaID(pelu_id);    // Recuperamos la peluqueria
            return View(peluEditar);    // Retornamos la vista
        }

        [HttpPost]
        public async Task<IActionResult> Editar(Peluqueria peluqueria) {
            GrupoPeluqueria grupoActual = deserializarGrupo();  // Recuperamos el grupo
            var peluCorreo = await _grupoPeluqueriasRepository.getPeluqueriaID(peluqueria.pelu_id); // Recuperamos el correo actual del grupo

            if(peluCorreo.pelu_correo_electronico != peluqueria.pelu_correo_electronico) {  // Comparamos los correos
                var correo = await _grupoPeluqueriasRepository.comprobarCorreoPeluquerias(peluqueria.pelu_correo_electronico);  //Comprobamos que no haya uno igual en la BBDD
                if(correo) {    // Validamos
                    ModelState.AddModelError("pelu_correo_electronico", "El correo electrónico ya está en uso.");   // Mensaje de error en caso de que el correo introducido está en la BBDD
                    return View("EditarPeluqueria", peluqueria);    // Retornamos la vista
                }
            }

            await _grupoPeluqueriasRepository.Editar(peluqueria);   // Editamos la peluqueria
            var grupoPeluquerias = _grupoPeluqueriasRepository.GetPeluquerias(grupoActual); // Recuperamos las peluquerias del grupo
            return View("Portal", grupoPeluquerias);    // Retornamos la vista
        }

        [HttpPost]
        public async Task<IActionResult> Eliminar(Peluqueria peluqueria) {
            GrupoPeluqueria grupoActual = deserializarGrupo();  // Recuperamos el grupo
            await _grupoPeluqueriasRepository.Eliminar(peluqueria); // Eliminamos la peluqueria
            var grupoPeluquerias = _grupoPeluqueriasRepository.GetPeluquerias(grupoActual); // Recuperamos las peluquerias del grupo
            return View("Portal", grupoPeluquerias);    // Retornamos la vista
        }

        public async Task<IActionResult> EditarGrupo(int gp_id) {
            var grupoEditar = await _grupoPeluqueriasRepository.getGrupoPeluqueria(gp_id);    // Recuperamos la peluqueria
            return View(grupoEditar);    // Retornamos la vista
        }

        [HttpPost]
        public async Task<IActionResult> EditarGP(GrupoPeluqueria gp) {
            GrupoPeluqueria grupoActual = deserializarGrupo();  // Recuperamos el grupo
            if (grupoActual.gp_correo_electronico != gp.gp_correo_electronico) {
                var correo = await _grupoPeluqueriasRepository.comprobarCorreoGrupo(gp.gp_correo_electronico);
                if(correo) {
                    ModelState.AddModelError("gp_correo_electronico", "El correo electrónico ya está en uso.");   // Mensaje de error en caso de que el correo introducido está en la BBDD
                    var grupoPeluqueriasError = _grupoPeluqueriasRepository.GetPeluquerias(gp); // Recuperamos las peluquerias del grupo
                    gp.peluquerias = grupoPeluqueriasError;
                    return View("EditarGrupo", gp);    // Retornamos la vista
                }
            }

            await _grupoPeluqueriasRepository.EditarGrupo(gp);
            serializarGrupo(gp);
            var grupoPeluquerias = _grupoPeluqueriasRepository.GetPeluquerias(gp); // Recuperamos las peluquerias del grupo
            gp.peluquerias = grupoPeluquerias;
            return View("Portal", gp);    // Retornamos la vista
        }

        [HttpPost]
        public async Task<IActionResult> EliminarGP(GrupoPeluqueria gp) {
            await _grupoPeluqueriasRepository.EliminarGrupo(gp);
            return RedirectToAction("Index", "Home");
        }

        public void serializarGrupo(GrupoPeluqueria grupo) {
            string json = JsonConvert.SerializeObject(grupo);
            HttpContext.Session.SetString("GrupoActual", json);
        }

        public GrupoPeluqueria deserializarGrupo() {
            GrupoPeluqueria grupo = new GrupoPeluqueria();
            string json = HttpContext.Session.GetString("GrupoActual");
            grupo = JsonConvert.DeserializeObject<GrupoPeluqueria>(json);
            return grupo;
        }
    }
}
