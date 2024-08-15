using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Peluqueria;

namespace MyReserve.Models.Repository.RepositoryGrupoPeluquerias {
    public interface IGrupoPeluquerias {
        IEnumerable<Peluqueria> GetPeluquerias(GrupoPeluqueria gp);
        Task<Peluqueria> getPeluqueriaID(int pelu_id);
        Task Editar(Peluqueria peluqueria);
        Task Eliminar (Peluqueria peluqueria);
        Task<bool> comprobarCorreoGrupo(string gp_correo_electronico);
        Task<bool> comprobarCorreoPeluquerias(string pelu_correo_electronico);
        Task<GrupoPeluqueria> getGrupoPeluqueria(int gp_id);
    }
}
