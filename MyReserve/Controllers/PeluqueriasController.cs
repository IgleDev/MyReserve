﻿using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.Repository.RepositoryPeluqueria;
using MyReserve.Models.Repository.RepositoryUsuarios;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Usuarios;
using Newtonsoft.Json;

namespace MyReserve.Controllers {
    public class PeluqueriasController : Controller {
        private readonly IPeluqueria _peluqueriasRepository;
        public PeluqueriasController(IPeluqueria peluqueriasRepository) {
            _peluqueriasRepository = peluqueriasRepository;
        }

        public async Task<IActionResult> Portal() {
            Peluqueria peluActual = deserializarPeluqueria();   // Recuperamos la peluqueria
            var peluqueros = _peluqueriasRepository.GetPeluqueros(peluActual);  // Recuperamos los peluqueros
            var grupoPeluqueros = _peluqueriasRepository.GrupoIdNombre(peluActual.pelu_gp_id_fk);   // Recuperamos el id del peluquero mediante el nombre
            var serviciosPeluqueria = await _peluqueriasRepository.getServiciosPeluqueria(peluActual.pelu_id);
            var horariosPeluqueria = await _peluqueriasRepository.getHorariosPeluqueria(peluActual.pelu_id);
            peluActual.peluqueros = peluqueros; // Le pasamos los peluqueros a la lista de la peluqueria
            peluActual.grupoPeluqueria = grupoPeluqueros;   // Le pasamos el grupo de peluqueros a la peluqueria
            peluActual.Servicios = serviciosPeluqueria.ToList();    // Le pasamos los servicios
            peluActual.Horarios = horariosPeluqueria.ToList();  // Le pasamos los horarios
            serializarPeluqueria(peluActual);   // Guardamos en sesión
            return View(peluActual);    // Retornamos peluqueria
        }

        public async Task<IActionResult> InfoPeluqueros(int pel_id) {
            var infoPeluqueros = await _peluqueriasRepository.getPeluquero(pel_id);   // Según el ID del peluquero mandamos a la vista del peluquero correspondiente
            return View(infoPeluqueros);    //  Mandamos la vista
        }

        [HttpPost]
        public async Task<IActionResult> GuardarDatosPeluqueriaPeluqueros(Peluqueros peluquero) {
            await _peluqueriasRepository.EditarPeluquero(peluquero); // Pasamos el peluquero a modificar
            serializarPeluquero(peluquero);    // Guardamos el peluquero modificado en la sesión
            return RedirectToAction("Portal");  //  Redirigimos a la vista
        }

        public async Task<IActionResult> PeluqueroPortal(int pel_id) {
            var peluqueroEditar = await _peluqueriasRepository.getPeluquero(pel_id);    // Recuperamos el peluquero
            var peluqueroPeluqueria = _peluqueriasRepository.PeluqueriaIDNombre(peluqueroEditar.pel_pelu_id_fk);    // Recuperamos el nombre de la peluqueria
            var peluqueroGrupo = _peluqueriasRepository.GrupoIdNombre(peluqueroEditar.pel_grupo_id_fk); // Recuperamos el nombre del grupo
            peluqueroEditar.peluqueria = peluqueroPeluqueria;   // se los añadismos a la propiedad de la clase
            peluqueroEditar.grupoPeluqueria = peluqueroGrupo;
            return View(peluqueroEditar);   // Mandamos la vista
        }

        [HttpPost]
        public async Task<IActionResult> GuardarDatosPeluqueros(Peluqueros peluquero) {
            await _peluqueriasRepository.EditarPeluquero(peluquero); // Pasamos el peluquero a modificar
            serializarPeluquero(peluquero);    // Guardamos el peluquero modificado en la sesión
            var peluqueroEditar = await _peluqueriasRepository.getPeluquero(peluquero.pel_id);
            return View("PeluqueroPortal", peluqueroEditar);  //  Redirigimos a la vista
        }

        [HttpPost]
        public async Task<IActionResult> EliminarDatosPeluqueriaPeluqueros(int pel_id) {
            var peluActual = deserializarPeluqueria();  // Recuperamos la peluqueria
            await _peluqueriasRepository.EliminarPeluqueroPeluqueria(pel_id);   // Eliminamos el peluquero por su ID
            var peluqueros = _peluqueriasRepository.GetPeluqueros(peluActual);  // Volvemos a recuperar todos los peluqueros
            peluActual.peluqueros = peluqueros; // Los añadidos a la propiedad de la clase
            return View("Portal", peluActual);  // Mandamos la peluquerias
        }

        public async Task<IActionResult> CitasPeluquero(int pel_id) {
            var peluqueroCitas = await _peluqueriasRepository.getCitasPeluquero(pel_id);    // Recuperamos las citas del peluquero por su ID
            return View(peluqueroCitas.ToList());   // Mandamos la vista convertida en un ToList();
        }

        public async Task<IActionResult> CitasPeluqueria(int pelu_id) { 
            var peluActual = deserializarPeluqueria();  // Recuperamos la peluqueria
            ViewBag.peluNombre = peluActual.pelu_nombre;    // Pasamos el nombre de la peluqueria mediante un ViewBag
            var peluqueriaCitas = await _peluqueriasRepository.getCitasPeluqueria(pelu_id); // Recuperamos las citas
            return View(peluqueriaCitas.ToList());  // Mandamos la vista convertida en un ToList();
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

        public void serializarPeluquero(Peluqueros peluquero) {
            string json = JsonConvert.SerializeObject(peluquero);
            HttpContext.Session.SetString("PeluqueroActual", json);
        }

        public Peluqueros deserializarPeluquero() {
            Peluqueros peluquero = new Peluqueros();
            string json = HttpContext.Session.GetString("PeluqueroActual");
            peluquero = JsonConvert.DeserializeObject<Peluqueros>(json);
            return peluquero;
        }
    }
}
