using Dapper;
using MyReserve.Models.TablasBBDD.Paises;
using MyReserve.Models.TablasBBDD.Usuarios;
using MyReserve.Models.TablasBBDD.Region;
using System.Data;

namespace MyReserve.Models.Repository.RepositoryUsuario {
    public class IInfoUsuariosRepository : IInfoUsuarios{
        private readonly Conexion _conexion;

        public IInfoUsuariosRepository(Conexion conexion) {
            _conexion = conexion;
        }

        public IEnumerable<Paises> getPaises() {
            var query = "SELECT pai_nombre FROM Paises";
            using(var connection = _conexion.getConexion()) {
                var paises = connection.Query<Paises>(query);
                return paises;
            }
        }

        public async Task Editar(Usuarios usuario) {
            var query = "UPDATE Usuarios SET usu_nombre = @usu_nombre, usu_correo_electronico = @usu_correo_electronico, " +
                "usu_contrasenha = @usu_contrasenha WHERE usu_id = @usu_id";
            var parametros = new DynamicParameters();
            parametros.Add("usu_nombre", usuario.usu_nombre, DbType.String);
            parametros.Add("usu_correo_electronico", usuario.usu_correo_electronico, DbType.String);
            parametros.Add("usu_contrasenha", usuario.usu_contrasenha, DbType.String);
            parametros.Add("usu_id", usuario.usu_id, DbType.Int32);
            using(var connection = _conexion.getConexion()) {
               await connection.ExecuteAsync(query, parametros);
            }
        }

        public async Task Eliminar(int usu_id) {
            var query = "DELETE FROM Usuarios WHERE usu_id = @usu_id";
            var parametros = new DynamicParameters();
            parametros.Add("usu_id", usu_id, DbType.Int32);

            using(var connection = _conexion.getConexion()) {
                await connection.ExecuteAsync(query, parametros);
            }
        }

        public async Task<IEnumerable<Region>> getRegionesPais(string pai_nombre) {
            var query = "SELECT reg_nombre FROM Region " +
                "INNER JOIN Paises AS pai ON pai.pai_id = reg_pai_id_fk " +
                "WHERE pai_nombre = @pai_nombre";

            using(var connection = _conexion.getConexion()) {
                return await connection.QueryAsync<Region>(query, new { pai_nombre = pai_nombre });
            }
        }
    }
}
