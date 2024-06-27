using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.Repository.RepositoryPeluqueria;
using MyReserve.Models.Repository.RepositoryUsuarios;
using MyReserve.Models.TablasBBDD.Peluqueria;
using Newtonsoft.Json;

namespace MyReserve.Controllers {
    public class PeluqueriasController : Controller {
        private readonly IPeluqueria _peluqueriasRepository;
        public PeluqueriasController(IPeluqueria peluqueriasRepository) {
            _peluqueriasRepository = peluqueriasRepository;
        }

        public IActionResult Portal() {
            Peluqueria peluActual = deserializarPeluqueria();
            var peluqueros = _peluqueriasRepository.GetPeluqueros(peluActual);
            var grupoPeluqueros = _peluqueriasRepository.GrupoIdNombre(peluActual.pelu_gp_id_fk);
            peluActual.peluqueros = peluqueros;
            peluActual.grupoPeluqueria = grupoPeluqueros;
            serializarPeluqueria(peluActual);
            return View(peluActual); 
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
