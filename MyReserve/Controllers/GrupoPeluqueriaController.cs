using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.Repository.RepositoryGrupoPeluquerias;
using MyReserve.Models.Repository.RepositoryUsuarios;
using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Usuarios;
using Newtonsoft.Json;

namespace MyReserve.Controllers {
    public class GrupoPeluqueriaController : Controller {
        private readonly IGrupoPeluquerias _grupoPeluqueriasRepository;
        public GrupoPeluqueriaController(IGrupoPeluquerias grupoPeluqueriasRepository) {
            _grupoPeluqueriasRepository = grupoPeluqueriasRepository;
        }

        public IActionResult Portal() {
            GrupoPeluqueria grupoActual = deserializarGrupo();  // Recuperamos el grupo
            ViewBag.grupoID = grupoActual.gp_id;
            var grupoPeluquerias = _grupoPeluqueriasRepository.GetPeluquerias(grupoActual); // Recuperamos las peluquerias del grupo
            grupoActual.peluquerias = grupoPeluquerias; // Añadimos las peluquerias a la lista del grupo
            serializarGrupo(grupoActual);   // Guardamos en sesión
            return View(grupoPeluquerias);  // Retornamos el grupo
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
            var peluCorreo = await _grupoPeluqueriasRepository.getPeluqueriaID(peluqueria.pelu_id);

            if(peluCorreo.pelu_correo_electronico != peluqueria.pelu_correo_electronico) {
                var correo = await _grupoPeluqueriasRepository.comprobarCorreoPeluquerias(peluqueria.pelu_correo_electronico);
                if(correo) {
                    ModelState.AddModelError("pelu_correo_electronico", "El correo electrónico ya está en uso.");
                    return View("EditarPeluqueria", peluqueria);
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
