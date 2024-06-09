using Dapper;
using MyReserve.Models.TablasBBDD.Usuarios;

namespace MyReserve.Models.Repository.RepositoryUsuarios {
    public class FormularioRepository : IFormulario {
        private readonly Conexion _conexion;
        public FormularioRepository(Conexion conexion) {
            _conexion = conexion;
        }

        public async Task<Usuarios> Login(string usu_correo_electronico, string usu_contrasenha) {
            var query = "SELECT * FROM Usuarios WHERE usu_correo_electronico = @usu_correo_electronico" +
                "AND usu_contrasenha = @usu_contrasenha";
            using(var connection = _conexion.getConexion()) {
                var usuario = await connection.QueryFirstOrDefaultAsync<Usuarios>(query, new { usu_correo_electronico, usu_contrasenha });
                return usuario;
            }
        }
    }
}
