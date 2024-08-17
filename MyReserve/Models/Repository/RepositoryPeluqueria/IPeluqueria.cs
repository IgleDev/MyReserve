using MyReserve.Models.TablasBBDD.Categorias;
using MyReserve.Models.TablasBBDD.Cita;
using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Horarios;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Servicios;

namespace MyReserve.Models.Repository.RepositoryPeluqueria {
    public interface IPeluqueria {
        IEnumerable<Peluqueros> getPeluqueros(Peluqueria pelu);
        Task EditarPeluquero(Peluqueros peluquero);
        Task<GrupoPeluqueria> GrupoIdNombre(string gp_id);
        Task<Peluqueria> PeluqueriaIDNombre(string pelu_id);
        Task<IEnumerable<Servicios>> getServiciosPeluqueria(int pelu_id);
        Task<IEnumerable<Horarios>> getHorariosPeluqueria(int pelu_id);
        Task<Peluqueros> getPeluquero(int pel_id);
        Task EliminarPeluqueroPeluqueria(int pel_id);
        Task<IEnumerable<Cita>> getCitasPeluquero(int pel_id);
        Task<IEnumerable<Cita>> getCitasPeluqueria(int pelu_id);
        Task<bool> comprobarCorreoPeluquero(string pel_correo_electronico);
        Task<Peluqueria> getPeluqueria(int pelu_id);
        Task<IEnumerable<Categorias>> getCategorias();
        Task CrearServicios(Servicios servicio);
    }
}
