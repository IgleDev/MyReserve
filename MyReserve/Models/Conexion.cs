using System.Data.SqlClient;

namespace MyReserve.Models {
    public class Conexion {
        private readonly string _conexion;

        public Conexion(string conexion) {
            _conexion = conexion;
        }

        public SqlConnection getConexion() {
            var conexion = new SqlConnection(_conexion);    // Nos conectamos a la BBDD
            conexion.Open();    // Abrimos la conexion
            return conexion;
        }
    }
}
