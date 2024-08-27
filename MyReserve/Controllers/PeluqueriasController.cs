using Microsoft.AspNetCore.Mvc;
using MyReserve.Models.Repository.RepositoryPeluqueria;
using MyReserve.Models.TablasBBDD.Categorias;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Servicios;
using Newtonsoft.Json;

namespace MyReserve.Controllers {
    public class PeluqueriasController : Controller {
        private readonly IPeluqueria _peluqueriasRepository;
        public PeluqueriasController(IPeluqueria peluqueriasRepository) {
            _peluqueriasRepository = peluqueriasRepository;
        }

        public async Task<IActionResult> Portal() {
            Peluqueria peluActual = deserializarPeluqueria();   // Recuperamos la peluqueria
            var errorVista = returnHome(peluActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            var peluqueros = _peluqueriasRepository.getPeluqueros(peluActual);  // Recuperamos los peluqueros
            var grupoPeluqueros = await _peluqueriasRepository.GrupoIdNombre(peluActual.pelu_gp_id_fk);   // Recuperamos el id del peluquero mediante el nombre
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
            var pelActual = deserializarPeluqueria();  // Recuperamos la peluqueria
            var errorVista = returnHome(pelActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            var infoPeluqueros = await _peluqueriasRepository.getPeluquero(pel_id);   // Según el ID del peluquero mandamos a la vista del peluquero correspondiente
            return View(infoPeluqueros);    //  Mandamos la vista
        }

        [HttpPost]
        public async Task<IActionResult> GuardarDatosPeluqueriaPeluqueros(Peluqueros peluquero) {
            var peluqueroCorreo = await _peluqueriasRepository.getPeluquero(peluquero.pel_id);  // Recuperamos el peluquero para conseguir el correo
            
            if(peluquero.pel_correo_electronico != peluqueroCorreo.pel_correo_electronico) {    // Comparamos el correo que le estamos pasando con el actual
                var correo = await _peluqueriasRepository.comprobarCorreoPeluquero(peluquero.pel_correo_electronico);   // Comprovamos el correo que le pasamos
                if(correo) {    // Comprobamos si el correo está en uso
                    ModelState.AddModelError("pel_correo_electronico", "El correo electrónico ya está en uso.");    // Mandamos mensaje informativo
                    return View("InfoPeluqueros", peluquero);   // Retornamos la vista
                }
            }
            await _peluqueriasRepository.EditarPeluquero(peluquero); // Pasamos el peluquero a modificar
            serializarPeluquero(peluquero);    // Guardamos el peluquero modificado en la sesión
            return RedirectToAction("Portal");  //  Redirigimos a la vista
        }

        public async Task<IActionResult> PeluqueroPortal(int pel_id) {
            var peluActual = deserializarPeluquero();   // Recuperamos el peluquero en sesion
            var errorVista = returnHome(peluActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            var peluqueroEditar = await _peluqueriasRepository.getPeluquero(pel_id);    // Recuperamos el peluquero
            var peluqueroPeluqueria = await _peluqueriasRepository.PeluqueriaIDNombre(peluqueroEditar.pel_pelu_id_fk);    // Recuperamos el nombre de la peluqueria
            var peluqueroGrupo = await _peluqueriasRepository.GrupoIdNombre(peluqueroEditar.pel_grupo_id_fk); // Recuperamos el nombre del grupo
            peluqueroEditar.peluqueria = peluqueroPeluqueria;   // se los añadismos a la propiedad de la clase
            peluqueroEditar.grupoPeluqueria = peluqueroGrupo;
            return View(peluqueroEditar);   // Mandamos la vista
        }

        public async Task<IActionResult> CrearServicios(int pelu_id) {
            var peluActual = deserializarPeluqueria();   // Recuperamos el peluquero en sesion
            var errorVista = returnHome(peluActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            var peluServicioCrear = await _peluqueriasRepository.getPeluqueria(pelu_id);    // Recuperamos la peluquería
            var peluCategorias = await _peluqueriasRepository.getCategorias() ?? new List<Categorias>();    // Recuperamos las categorias
            ViewBag.pelu_nombre = peluServicioCrear.pelu_nombre;    // Pasamos viewbags necesarios
            ViewBag.pelu_id = peluServicioCrear.pelu_id;
            ViewBag.Categorias = peluCategorias;
            return View();  // Retornamos vista
        }

        [HttpPost]
        public async Task<IActionResult> CrearServicioPeluqueria(Servicios servicios) {
            var nuevoServicio = new Servicios { // Creamos el nuevo servicio
                ser_nombre = servicios.ser_nombre,
                ser_precio = (int)Math.Ceiling(servicios.ser_precio),
                ser_cat_id_fk = servicios.ser_cat_id_fk,
                ser_pelu_id_fk = servicios.ser_pelu_id_fk,
            };

            await _peluqueriasRepository.CrearServicios(nuevoServicio); // Se lo pasamos
            return RedirectToAction("Portal", new { servicios.ser_pelu_id_fk });    // Redireccionamos la vista con la id de la peluquería
        }

        public async Task<IActionResult> EditarServiciosPeluqueria(int pelu_id) {
            var peluActual = deserializarPeluqueria();   // Recuperamos el peluquero en sesion
            var errorVista = returnHome(peluActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            var peluServicioCrear = await _peluqueriasRepository.getPeluqueria(pelu_id);    // Recogemos la peluquería
            var peluCategorias = await _peluqueriasRepository.getCategorias() ?? new List<Categorias>();    // Recuperamos las categorias
            var peluServicioPeluqueria = await _peluqueriasRepository.getServiciosPeluqueriaCreados(pelu_id) ?? new List<Servicios>();  // Recuperamos los servicios creados por la peluquería
            ViewBag.pelu_nombre = peluServicioCrear.pelu_nombre;    // Pasamos viewbags necesarios para el código
            ViewBag.Categorias = peluCategorias;
            return View(peluServicioPeluqueria.ToArray());  // Devolvemos la vista con un array
        }

        [HttpPost]
        public async Task<IActionResult> guardarDatosServicios(Servicios []sers) {
            var peluActual = deserializarPeluqueria();  // Recuperamos la peluquería
            var errorVista = returnHome(peluActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            foreach(var servicio in sers) { // Por cada iteracción guardamos el servicio editado
                await _peluqueriasRepository.actualizarServicioPeluqueria(servicio.ser_id, servicio.ser_nombre, servicio.ser_precio, servicio.ser_cat_id_fk);
            }

            var peluqueros = _peluqueriasRepository.getPeluqueros(peluActual);  // Recuperamos los peluqueros
            var grupoPeluqueros = await _peluqueriasRepository.GrupoIdNombre(peluActual.pelu_gp_id_fk);   // Recuperamos el id del peluquero mediante el nombre
            var serviciosPeluqueria = await _peluqueriasRepository.getServiciosPeluqueria(peluActual.pelu_id);
            var horariosPeluqueria = await _peluqueriasRepository.getHorariosPeluqueria(peluActual.pelu_id);
            peluActual.peluqueros = peluqueros; // Le pasamos los peluqueros a la lista de la peluqueria
            peluActual.grupoPeluqueria = grupoPeluqueros;   // Le pasamos el grupo de peluqueros a la peluqueria
            peluActual.Servicios = serviciosPeluqueria.ToList();    // Le pasamos los servicios
            peluActual.Horarios = horariosPeluqueria.ToList();  // Le pasamos los horarios
            serializarPeluqueria(peluActual);   // Guardamos en sesión
            return View("Portal", peluActual);    // Retornamos peluqueria
        }


        public async Task<IActionResult> EliminarServiciosPeluqueria(int ser_id) {
            var peluActual = deserializarPeluqueria();  // Recuperamos la peluquería
            var errorVista = returnHome(peluActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            await _peluqueriasRepository.EliminarServicioPeluqueriaCreado(ser_id);  // LLamamos al método
            var peluServicioCrear = await _peluqueriasRepository.getPeluqueria(peluActual.pelu_id); // Metemos el código necesario para volver a mandar la vista
            var peluCategorias = await _peluqueriasRepository.getCategorias() ?? new List<Categorias>();
            var peluServicioPeluqueria = await _peluqueriasRepository.getServiciosPeluqueriaCreados(peluActual.pelu_id) ?? new List<Servicios>();
            ViewBag.pelu_nombre = peluServicioCrear.pelu_nombre;
            ViewBag.Categorias = peluCategorias;
            return View("EditarServiciosPeluqueria", peluServicioPeluqueria.ToArray()); // La retornamos
        }

        [HttpPost]
        public async Task<IActionResult> GuardarDatosPeluqueros(Peluqueros peluquero) {
            var peluqueroCorreo = await _peluqueriasRepository.getPeluquero(peluquero.pel_id);  // Recuperamos el peluquero para conseguir el correo

            if(peluquero.pel_correo_electronico != peluqueroCorreo.pel_correo_electronico) {    // Comparamos el correo que le estamos pasando con el actual
                var correo = await _peluqueriasRepository.comprobarCorreoPeluquero(peluquero.pel_correo_electronico);   // Comprobamos el correo que le pasamos
                if(correo) {    // Si el correo está en uso
                    ModelState.AddModelError("pel_correo_electronico", "El correo electrónico introducido ya está en uso.");    // Mandamos mensaje informativo
                    var peluqueroPeluqueriaError = await _peluqueriasRepository.PeluqueriaIDNombre(peluqueroCorreo.pel_pelu_id_fk); // Volvemos a enviar la información pertinente a la vista
                    var peluqueroGrupoError = await _peluqueriasRepository.GrupoIdNombre(peluqueroCorreo.pel_grupo_id_fk);
                    peluqueroCorreo.peluqueria = peluqueroPeluqueriaError;  
                    peluqueroCorreo.grupoPeluqueria = peluqueroGrupoError;
                    return View("PeluqueroPortal", peluqueroCorreo);    // Retornamos la vista
                }
            }

            await _peluqueriasRepository.EditarPeluquero(peluquero); // Pasamos el peluquero a modificar
            serializarPeluquero(peluquero);    // Guardamos el peluquero modificado en la sesión
            var peluqueroEditar = await _peluqueriasRepository.getPeluquero(peluquero.pel_id);
            var peluqueroPeluqueria = await _peluqueriasRepository.PeluqueriaIDNombre(peluqueroEditar.pel_pelu_id_fk);
            var peluqueroGrupo =  await _peluqueriasRepository.GrupoIdNombre(peluqueroEditar.pel_grupo_id_fk);
            peluqueroEditar.peluqueria = peluqueroPeluqueria;
            peluqueroEditar.grupoPeluqueria = peluqueroGrupo;
            return View("PeluqueroPortal", peluqueroEditar);  //  Redirigimos a la vista
        }

        [HttpPost]
        public async Task<IActionResult> EliminarDatosPeluqueriaPeluqueros(int pel_id) {
            var peluActual = deserializarPeluqueria();  // Recuperamos la peluqueria
            await _peluqueriasRepository.EliminarPeluqueroPeluqueria(pel_id);   // Eliminamos el peluquero por su ID
            var peluqueros = _peluqueriasRepository.getPeluqueros(peluActual);  // Volvemos a recuperar todos los peluqueros
            peluActual.peluqueros = peluqueros; // Los añadidos a la propiedad de la clase
            return View("Portal", peluActual);  // Mandamos la peluquerias
        }

        public async Task<IActionResult> CitasPeluquero(int pel_id) {
            var pelActual = deserializarPeluquero();    // Recuperamos el peluquero
            var errorVista = returnHome(pelActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            ViewBag.pel_id = pelActual.pel_id;
            var peluqueroCitas = await _peluqueriasRepository.getCitasPeluquero(pel_id);    // Recuperamos las citas del peluquero por su ID
            return View(peluqueroCitas.ToList());   // Mandamos la vista convertida en un ToList();
        }

        public async Task<IActionResult> CitasPeluqueria(int pelu_id) { 
            var peluActual = deserializarPeluqueria();  // Recuperamos la peluqueria
            var errorVista = returnHome(peluActual); // Función para comprobar si la peluqueria actual está vacia y retornar a la vista Home

            if(errorVista != null) {
                return errorVista;
            }

            ViewBag.pelu_id = peluActual.pelu_id;
            ViewBag.peluNombre = peluActual.pelu_nombre;    // Pasamos el nombre de la peluqueria mediante un ViewBag
            var peluqueriaCitas = await _peluqueriasRepository.getCitasPeluqueria(pelu_id); // Recuperamos las citas
            return View(peluqueriaCitas.ToList());  // Mandamos la vista convertida en un ToList();
        }

        public async Task<IActionResult> VerPeluqueros(int pelu_id) {
            Peluqueria peluqueriaActual = await _peluqueriasRepository.getPeluqueria(pelu_id);
            var peluquerosPeluqueria = _peluqueriasRepository.getPeluqueros(peluqueriaActual);
            peluqueriaActual.peluqueros = peluquerosPeluqueria;
            return View(peluqueriaActual);
        }

        public void serializarPeluqueria(Peluqueria peluqueria) {
            string json = JsonConvert.SerializeObject(peluqueria);
            HttpContext.Session.SetString("PeluqueriaActual", json);
        }

        public Peluqueria deserializarPeluqueria() {
            Peluqueria peluqueria = new Peluqueria();
            string json = HttpContext.Session.GetString("PeluqueriaActual");

            if(string.IsNullOrEmpty(json)) {
                return null;
            }

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

            if(string.IsNullOrEmpty(json)) {
                return null;
            }
            peluquero = JsonConvert.DeserializeObject<Peluqueros>(json);
            return peluquero;
        }

        private IActionResult returnHome(object entidad) {  // Método privado para redireccionar si la entidad es null
            if(entidad == null) {
                return RedirectToAction("Index", "Home");
            }

            return null;
        }
    }
}
