using Dapper;
using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Peluqueria;

namespace MyReserve.Models.Repository.RepositoryGrupoPeluquerias {
    public class GrupoPeluqueriasRepository : IGrupoPeluquerias{
        private readonly Conexion _conexion;
        public GrupoPeluqueriasRepository(Conexion conexion) {
            _conexion = conexion;
        }

        public IEnumerable<Peluqueria> GetPeluquerias(GrupoPeluqueria gp) {
            var query = "SELECT pelu.pelu_nombre FROM Peluqueria AS pelu " +
                "INNER JOIN GrupoPeluqueria AS gp ON gp.gp_id = pelu.pelu_gp_id_fk " +
                "WHERE pelu_gp_id_fk = @gp_id";

            using(var conexion = _conexion.getConexion()) {
                var peluquerias = conexion.Query<Peluqueria>(query, new { gp.gp_id });
                return peluquerias;
            }
        }
    }
}
