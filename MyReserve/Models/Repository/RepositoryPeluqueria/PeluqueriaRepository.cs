using Dapper;
using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;

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
    }
}
