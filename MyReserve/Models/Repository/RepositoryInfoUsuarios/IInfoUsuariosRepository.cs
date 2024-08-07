using Dapper;
using MyReserve.Models.TablasBBDD.Paises;
using MyReserve.Models.TablasBBDD.Usuarios;
using MyReserve.Models.TablasBBDD.Region;
using System.Data;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Horarios;
using MyReserve.Models.TablasBBDD.Servicios;

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
                return await connection.QueryAsync<Region>(query, new { pai_nombre });
            }
        }

        public async Task<IEnumerable<Peluqueria>> getPeluqueriasFiltro(string pelu_pais, string pelu_region, string pelu_ciudad) {
            var query = "SELECT * FROM Peluqueria " +
                "WHERE pelu_pais = @pelu_pais AND pelu_region = @pelu_region AND pelu_ciudad = @pelu_ciudad";

            using(var connection = _conexion.getConexion()) {
                return await connection.QueryAsync<Peluqueria>(query, new { pelu_pais, pelu_region, pelu_ciudad });
            }
        }

        public async Task<Peluqueria> getPeluqueriaID(int pelu_id) {
            var query = "SELECT * FROM Peluqueria WHERE pelu_id = @pelu_id";

            using(var connection = _conexion.getConexion()) {
                var peluqueria = connection.QueryFirstOrDefault<Peluqueria>(query, new { pelu_id });
                return peluqueria;
            }
        }

        public async Task<IEnumerable<Peluqueros>> getPeluquerosPeluqueriaID(int pelu_id) {
            var query = "SELECT pel.* FROM Peluquero AS pel " +
                "INNER JOIN Peluqueria AS pelu ON pelu.pelu_id = pel.pel_pelu_id_fk " +
                "WHERE pelu_id = @pelu_id";

            using(var connection = _conexion.getConexion()) {
                return await connection.QueryAsync<Peluqueros>(query, new { pelu_id });
            }
        }

        public async Task<IEnumerable<Servicios>> getServiciosPeluqueria(int pelu_id) {
            var query = "SELECT ser.ser_id, ser.ser_nombre, cat.cat_nombre, " +
                "CASE " +
                    "WHEN pelu_ser.pelu_ser_pelu_id_fk IS NOT NULL " +
                    "THEN 1 " +
                    "ELSE 0 " +
                "END AS ser_asociado " +
                "FROM Servicios AS ser " +
                "INNER JOIN Categoria AS cat ON cat.cat_id = ser.ser_cat_id_fk " +
                "LEFT JOIN PeluqueriaServicios AS pelu_ser ON pelu_ser.pelu_ser_ser_id_fk = ser.ser_id AND pelu_ser.pelu_ser_pelu_id_fk = @pelu_id";

            using(var connection = _conexion.getConexion()) {
                var serviciosLista = await connection.QueryAsync<Servicios>(query, new { pelu_id });
                return serviciosLista;
            }
        }

        public async Task<IEnumerable<Horarios>> getHorariosPeluqueria(int pelu_id) {
            var query = "SELECT hora.hora_id, hora.hora_fecha,  " +
                "CASE " +
                    "WHEN pelu_hora.pelu_hora_pelu_id_fk IS NOT NULL " +
                    "THEN 1 " +
                    "ELSE 0 " +
                "END AS hora_asociado " +
                "FROM Horarios AS hora " +
                "LEFT JOIN PeluqueriaHorarios AS pelu_hora ON hora.hora_id = pelu_hora.pelu_hora_hora_id_fk " +
                "AND pelu_hora.pelu_hora_pelu_id_fk = @pelu_id";

            using(var connection = _conexion.getConexion()) {
                var horarios = await connection.QueryAsync<Horarios>(query, new { pelu_id });
                return horarios;
            }
        }
    }
}
