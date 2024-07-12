using MyReserve.Models.TablasBBDD.Paises;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Usuarios;

namespace MyReserve.Models.Repository.RepositoryUsuario {
    public interface IInfoUsuarios {
        IEnumerable<Paises> getPaises();
    }
}
