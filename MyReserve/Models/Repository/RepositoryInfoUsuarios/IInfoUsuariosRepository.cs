using Dapper;
using MyReserve.Models.TablasBBDD.Paises;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Usuarios;

namespace MyReserve.Models.Repository.RepositoryUsuario {
    public class IInfoUsuariosRepository : IInfoUsuarios{
        private readonly Conexion _conexion;

        public IInfoUsuariosRepository(Conexion conexion) {
            _conexion = conexion;
        }

        public async Task<IEnumerable<Paises>> getPaises() {
            var query = "SELECT pai_nombre FROM Paises";
            using(var connection = _conexion.getConexion()) {
                var paises = await connection.QueryAsync<Paises>(query);
                return paises;
            }
        }
    }
}
