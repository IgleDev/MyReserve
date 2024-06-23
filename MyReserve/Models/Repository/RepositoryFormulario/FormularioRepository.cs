using Dapper;
using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Usuarios;
using System.Data;

namespace MyReserve.Models.Repository.RepositoryUsuarios {
    public class FormularioRepository : IFormulario {
        private readonly Conexion _conexion;
        public FormularioRepository(Conexion conexion) {
            _conexion = conexion;
        }

        // Logins ->

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

        public async Task<Peluqueria> LoginPeluqueria(string pelu_correo_electronico, string pelu_contrasenha) {
            var query = "SELECT * FROM Peluqueria WHERE pelu_correo_electronico = @pelu_correo_electronico " +
                "AND pelu_contrasenha = @pelu_contrasenha";
            using(var connection = _conexion.getConexion()) {
                var peluqueria = await connection.QueryFirstOrDefaultAsync<Peluqueria>(query, new { pelu_correo_electronico, pelu_contrasenha });
                return peluqueria;
            }
        }

        public async Task<GrupoPeluqueria> LoginGrupo(string gp_correo_electronico, string gp_contrasenha) {
            var query = "SELECT * FROM GrupoPeluqueria WHERE gp_correo_electronico = @gp_correo_electronico " +
                "AND gp_contrasenha = @gp_contrasenha";

            using(var connection = _conexion.getConexion()) {
                var grupoPeluqueria = await connection.QueryFirstOrDefaultAsync<GrupoPeluqueria>(query, new { gp_correo_electronico, gp_contrasenha });
                return grupoPeluqueria;
            }
        }

        // Registros ->

        public async Task RegistroUsuario(Usuarios usuarios) {
            var query = "INSERT INTO Usuarios (usu_nombre, usu_correo_electronico, usu_contrasenha, usu_pais, usu_ciudad) " +
                "VALUES (@usu_nombre, @usu_correo_electronico, @usu_contrasenha, @usu_pais, @usu_ciudad)";
            var parametros = new DynamicParameters();
            parametros.Add("usu_nombre", usuarios.usu_nombre, DbType.String);
            parametros.Add("usu_correo_electronico", usuarios.usu_correo_electronico, DbType.String);
            parametros.Add("usu_contrasenha", usuarios.usu_contrasenha, DbType.String);
            parametros.Add("usu_ciudad", usuarios.usu_ciudad, DbType.String);
            parametros.Add("usu_pais", usuarios.usu_pais, DbType.String);

            using(var connection = _conexion.getConexion()) {
                await connection.ExecuteAsync(query, parametros);
            }
        }

        public async Task RegistroPeluqueros(Peluqueros peluqueros) {
            var query = "INSERT INTO Peluquero (pel_nombre, pel_correo_electronico, pel_contrasenha, pel_experiencia, " +
            "pel_instagram, pel_pelu_id_fk, pel_grupo_id_fk) VALUES " +
            "(@pel_nombre, @pel_correo_electronico, @pel_contrasenha, @pel_experiencia, @pel_instagram, " +
            "@pel_pelu_id_fk, @pel_grupo_id_fk)";

            var parametros = new DynamicParameters();
            parametros.Add("pel_nombre", peluqueros.pel_nombre, DbType.String);
            parametros.Add("pel_correo_electronico", peluqueros.pel_correo_electronico, DbType.String);
            parametros.Add("pel_contrasenha", peluqueros.pel_contrasenha, DbType.String);
            parametros.Add("pel_experiencia", peluqueros.pel_experiencia, DbType.Int32);
            parametros.Add("pel_instagram", peluqueros.pel_instagram, DbType.String);
            parametros.Add("pel_pelu_id_fk", peluqueros.pel_pelu_id_fk, DbType.Int32);
            parametros.Add("pel_grupo_id_fk", peluqueros.pel_grupo_id_fk, DbType.Int32);

            using(var connection = _conexion.getConexion()) {
                await connection.ExecuteAsync(query, parametros);
            }
        }

        public async Task RegistroPeluqueria(Peluqueria peluqueria) {
            var query = "INSERT INTO Peluqueria (pelu_nombre, pelu_correo_electronico, pelu_contrasenha, pelu_pais, " +
                "pelu_ciudad, pelu_telefono, pelu_gp_id_fk) VALUES (@pelu_nombre, @pelu_correo_electronico, @pelu_contrasenha, " +
                "@pelu_pais, @pelu_ciudad, @pelu_telefono, @pelu_gp_id_fk)";

            var parametros = new DynamicParameters();
            parametros.Add("pelu_nombre", peluqueria.pelu_nombre, DbType.String);
            parametros.Add("pelu_correo_electronico", peluqueria.pelu_nombre, DbType.String);
            parametros.Add("pelu_contrasenha", peluqueria.pelu_nombre, DbType.String);
            parametros.Add("pelu_pais", peluqueria.pelu_nombre, DbType.String);
            parametros.Add("pelu_ciudad", peluqueria.pelu_nombre, DbType.String);
            parametros.Add("pelu_telefono", peluqueria.pelu_nombre, DbType.String);
            parametros.Add("pelu_gp_id_fk", peluqueria.pelu_nombre, DbType.String);

            using(var connection = _conexion.getConexion()) {
                await connection.ExecuteAsync(query, parametros);
            }
        }

        public async Task RegistroGrupos(GrupoPeluqueria grupo) {
            var query = "INSERT INTO GrupoPeluqueria (gp_nombre, gp_correo_electronico, gp_contrasenha) VALUES " +
                "(@gp_nombre, @gp_correo_electronico, @gp_contrasenha)";

            var parametros = new DynamicParameters();
            parametros.Add("gp_nombre", grupo.gp_nombre, DbType.String);
            parametros.Add("gp_correo_electronico", grupo.gp_correo_electronico, DbType.String);
            parametros.Add("gp_contrasenha", grupo.gp_contrasenha, DbType.String);

            using(var connection = _conexion.getConexion()) {
                await connection.ExecuteAsync(query, parametros);
            }
        }

        // Helpers de Querys
        public async Task<int> PeluqueriaIDNombre(string pelu_nombre) {
            var query = "SELECT pelu_id FROM Peluqueria WHERE pelu_nombre = @pelu_nombre";
            using(var connection = _conexion.getConexion()) {
                return await connection.ExecuteScalarAsync<int>(query, new { pelu_nombre });
            }
        }

        public async Task<int> GrupoIdNombre(string gp_nombre) {
            var query = "SELECT gp_id FROM GrupoPeluqueria WHERE gp_nombre = @gp_nombre";
            using(var connection = _conexion.getConexion()) {
                return await connection.ExecuteScalarAsync<int>(query, new { gp_nombre });
            }
        }
    }
}
