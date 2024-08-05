using Dapper;
using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Horarios;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Servicios;
using NuGet.Protocol.Plugins;

namespace MyReserve.Models.Repository.RepositoryPeluqueria {
    public class PeluqueriaRepository : IPeluqueria {
        private readonly Conexion _conexion;
        public PeluqueriaRepository(Conexion conexion) {
            _conexion = conexion;
        }

        public IEnumerable<Peluqueros> GetPeluqueros(Peluqueria pelu) {
            var query = "SELECT pel.pel_nombre FROM Peluquero AS pel " +
                "INNER JOIN Peluqueria AS pelu ON pelu.pelu_id = pel.pel_pelu_id_fk " +
                "WHERE pel.pel_pelu_id_fk = @pelu_id";

            using(var connection = _conexion.getConexion()) {
                var peluqueros = connection.Query<Peluqueros>(query, new { pelu.pelu_id });
                return peluqueros;
            }
        }

        public GrupoPeluqueria GrupoIdNombre(string gp_id) {
            var query = "SELECT * FROM GrupoPeluqueria WHERE gp_id = @gp_id";
            using(var connection = _conexion.getConexion()) {
                return connection.QueryFirstOrDefault<GrupoPeluqueria>(query, new { gp_id });
            }
        }

        public async Task<IEnumerable<Servicios>> getServiciosPeluqueria(int pelu_id) {
            var query = "SELECT ser.*, " +
                "CASE " +
                    "WHEN pelu_ser.pelu_ser_pelu_id_fk IS NOT NULL " +
                    "THEN 1 " +
                    "ELSE 0 " +
                "END AS ser_asociado " +
                "FROM Servicios AS ser " +
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
