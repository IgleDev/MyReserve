using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.Repository.RepositoryPeluqueria;
using MyReserve.Models.TablasBBDD.Peluqueria;
using Newtonsoft.Json;

namespace MyReserve.Controllers {
    public class PeluqueriasController : Controller {
        private readonly IPeluqueria _peluqueriasRepository;
        public PeluqueriasController(IPeluqueria peluqueriasRepository) {
            _peluqueriasRepository = peluqueriasRepository;
        }

        public IActionResult Portal() {
            Peluqueria peluActual = deserializarPeluqueria();   // Recuperamos la peluqueria
            var peluqueros = _peluqueriasRepository.GetPeluqueros(peluActual);  // Recuperamos los peluqueros
            var grupoPeluqueros = _peluqueriasRepository.GrupoIdNombre(peluActual.pelu_gp_id_fk);   // Recuperamos el id del peluquero mediante el nombre
            peluActual.peluqueros = peluqueros; // Le pasamos los peluqueros a la lista de la peluqueria
            peluActual.grupoPeluqueria = grupoPeluqueros;   // Le pasamos el grupo de peluqueros al grupo
            serializarPeluqueria(peluActual);   // Guardamos en sesión
            return View(peluActual);    // Retornamos peluqueria
        }

        public void serializarPeluqueria(Peluqueria peluqueria) {
            string json = JsonConvert.SerializeObject(peluqueria);
            HttpContext.Session.SetString("PeluqueriaActual", json);
        }

        public Peluqueria deserializarPeluqueria() {
            Peluqueria peluqueria = new Peluqueria();
            string json = HttpContext.Session.GetString("PeluqueriaActual");
            peluqueria = JsonConvert.DeserializeObject<Peluqueria>(json);
            return peluqueria;
        }
    }
}
