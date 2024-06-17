using Dapper;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Usuarios;
using System.Data;

namespace MyReserve.Models.Repository.RepositoryUsuarios {
    public class FormularioRepository : IFormulario {
        private readonly Conexion _conexion;
        public FormularioRepository(Conexion conexion) {
            _conexion = conexion;
        }

        public async Task<Usuarios> Login(string usu_correo_electronico, string usu_contrasenha) {
            var query = "SELECT * FROM Usuarios WHERE usu_correo_electronico = @usu_correo_electronico " +
                "AND usu_contrasenha = @usu_contrasenha";
            using(var connection = _conexion.getConexion()) {
                var usuario = await connection.QueryFirstOrDefaultAsync<Usuarios>(query, new { usu_correo_electronico, usu_contrasenha });
                return usuario;
            }
        }

        public async Task<Peluqueros> LoginPeluquero(string pel_correo_electronico, string pel_contrasenha) {
            var query = "SELECT * FROM Peluquero WHERE pel_correo_electronico = @pel_correo_electronico " +
                "AND pel_contrasenha = @pel_contrasenha";
            using(var connection = _conexion.getConexion()) {
                var peluquero = await connection.QueryFirstOrDefaultAsync<Peluqueros>(query, new { pel_correo_electronico, pel_contrasenha });
                return peluquero;
            }
        }

        public async Task RegistroUsuario(Usuarios usuarios) {
            var query = "INSERT INTO Usuarios (usu_nombre, usu_correo_electronico, usu_contrasenha) " +
                "VALUES (@usu_nombre, @usu_correo_electronico, @usu_contrasenha)";
            var parametros = new DynamicParameters();
            parametros.Add("usu_nombre", usuarios.usu_nombre, DbType.String);
            parametros.Add("usu_correo_electronico", usuarios.usu_correo_electronico, DbType.String);
            parametros.Add("usu_contrasenha", usuarios.usu_contrasenha, DbType.String);

            using(var connection = _conexion.getConexion()) {
                await connection.ExecuteAsync(query, parametros);
            }
        }
    }
}
