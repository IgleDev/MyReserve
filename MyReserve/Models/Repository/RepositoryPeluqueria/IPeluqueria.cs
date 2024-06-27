using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;

namespace MyReserve.Models.Repository.RepositoryPeluqueria {
    public interface IPeluqueria {
        IEnumerable<Peluqueros> GetPeluqueros(Peluqueria pelu);

        GrupoPeluqueria GrupoIdNombre(string gp_id);
    }
}
