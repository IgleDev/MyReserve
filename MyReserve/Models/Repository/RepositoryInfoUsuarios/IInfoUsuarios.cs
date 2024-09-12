using MyReserve.Models.TablasBBDD.Cita;
using MyReserve.Models.TablasBBDD.Horarios;
using MyReserve.Models.TablasBBDD.Paises;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Servicios;
using MyReserve.Models.TablasBBDD.Usuarios;

namespace MyReserve.Models.Repository.RepositoryUsuario {
    public interface IInfoUsuarios {
        IEnumerable<Paises> getPaises();
        Task Editar(Usuarios usuario);
        Task Eliminar(int usu_id);
        Task<IEnumerable<MyReserve.Models.TablasBBDD.Region.Region>> getRegionesPais(string pai_nombre);
        Task<IEnumerable<Peluqueria>> getPeluqueriasFiltro(string pelu_pais, string pelu_region, string pelu_ciudad);
        Task<Peluqueria> getPeluqueriaID(int pelu_id);
        Task<IEnumerable<Peluqueros>> getPeluquerosPeluqueriaID(int pelu_id);
        Task<IEnumerable<Servicios>> getServiciosPeluqueria(int pelu_id);
        Task<IEnumerable<Horarios>> getHorariosPeluqueria(int pelu_id);
        Task<int> GuardarCita(Cita cita);
        Task<IEnumerable<Horarios>> getHorariosDisponibles(int pel_id, DateTime fechaCita);
        Task GuardarCitasServicios(int cita_id, List<int> servicios);
        Task<IEnumerable<Cita>> getCitasUsuario(int usu_id);
        Task EliminarCita(int cita_id);
        Task<bool> comprobarCorreoUsuario(string usu_correo_electronico);
        Task<bool> comprobarCitaUsuario(int usu_id, DateTime fechaCita);
    }
}
