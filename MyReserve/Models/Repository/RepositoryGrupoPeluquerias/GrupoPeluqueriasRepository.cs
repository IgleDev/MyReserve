using Dapper;
using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Usuarios;
using System.Data;

namespace MyReserve.Models.Repository.RepositoryGrupoPeluquerias {
    public class GrupoPeluqueriasRepository : IGrupoPeluquerias{
        private readonly Conexion _conexion;
        public GrupoPeluqueriasRepository(Conexion conexion) {
            _conexion = conexion;
        }

        public IEnumerable<Peluqueria> GetPeluquerias(GrupoPeluqueria gp) {
            var query = "SELECT pelu.* FROM Peluqueria AS pelu " +
                "INNER JOIN GrupoPeluqueria AS gp ON gp.gp_id = pelu.pelu_gp_id_fk " +
                "WHERE pelu_gp_id_fk = @gp_id";

            using(var conexion = _conexion.getConexion()) {
                var peluquerias = conexion.Query<Peluqueria>(query, new { gp.gp_id });
                return peluquerias;
            }
        }

        public async Task<Peluqueria> getPeluqueriaID(int pelu_id) {
            var query = "SELECT pelu.* FROM Peluqueria AS pelu " +
                "WHERE pelu_id = @pelu_id";

            using(var conexion = _conexion.getConexion()) {
                var peluqueria = await conexion.QueryFirstOrDefaultAsync<Peluqueria>(query, new { pelu_id });
                return peluqueria;
            }
        }

        public async Task Editar(Peluqueria peluqueria) {
            var query = "UPDATE Peluqueria SET pelu_nombre = @pelu_nombre, pelu_correo_electronico = @pelu_correo_electronico, " +
                "pelu_contrasenha = @pelu_contrasenha, pelu_direccion = @pelu_direccion, pelu_telefono = @pelu_telefono " +
                "WHERE pelu_id = @pelu_id";

            var parametros = new DynamicParameters();
            parametros.Add("pelu_nombre", peluqueria.pelu_nombre, DbType.String);
            parametros.Add("pelu_correo_electronico", peluqueria.pelu_correo_electronico, DbType.String);
            parametros.Add("pelu_contrasenha", peluqueria.pelu_contrasenha, DbType.String);
            parametros.Add("pelu_direccion", peluqueria.pelu_direccion, DbType.String);
            parametros.Add("pelu_telefono", peluqueria.pelu_telefono, DbType.Int32);
            parametros.Add("pelu_id", peluqueria.pelu_id, DbType.Int32);

            using(var conexion = _conexion.getConexion()) {
                 await conexion.ExecuteAsync(query, parametros);
            }
        }

        public async Task Eliminar(Peluqueria peluqueria) {
            var query = "DELETE FROM Peluqueria WHERE pelu_id = @pelu_id";
            var parametros = new DynamicParameters();
            parametros.Add("pelu_id", peluqueria.pelu_id, DbType.Int32);

            using(var conexion = _conexion.getConexion()) {
                await conexion.ExecuteAsync(query, parametros);
            }
        }
    }
}
