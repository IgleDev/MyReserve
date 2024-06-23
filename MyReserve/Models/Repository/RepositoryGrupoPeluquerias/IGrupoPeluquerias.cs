using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Peluqueria;

namespace MyReserve.Models.Repository.RepositoryGrupoPeluquerias {
    public interface IGrupoPeluquerias {
        IEnumerable<Peluqueria> GetPeluquerias(GrupoPeluqueria gp);
    }
}
