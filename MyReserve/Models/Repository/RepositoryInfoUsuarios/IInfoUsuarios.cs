using MyReserve.Models.TablasBBDD.Paises;
using MyReserve.Models.TablasBBDD.Usuarios;

namespace MyReserve.Models.Repository.RepositoryUsuario {
    public interface IInfoUsuarios {
        IEnumerable<Paises> getPaises();
        Task Editar(Usuarios usuario);
        Task Eliminar(int usu_id);
        Task<IEnumerable<MyReserve.Models.TablasBBDD.Region.Region>> getRegionesPais(string pai_nombre);
    }
}
