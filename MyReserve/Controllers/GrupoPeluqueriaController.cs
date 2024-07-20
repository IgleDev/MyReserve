using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.Repository.RepositoryGrupoPeluquerias;
using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
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
            return View(grupoPeluquerias);  // Retornamos el grupo
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
