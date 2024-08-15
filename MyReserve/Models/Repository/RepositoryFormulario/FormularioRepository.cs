using Dapper;
using MyReserve.Models.TablasBBDD.Region;
using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Paises;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Usuarios;
using System.Data;
using MyReserve.Models.TablasBBDD.Servicios;
using MyReserve.Models.TablasBBDD.Horarios;

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
            using(var conexion = _conexion.getConexion()) {
                var usuario = await conexion.QueryFirstOrDefaultAsync<Usuarios>(query, new { usu_correo_electronico, usu_contrasenha });
                return usuario;
            }
        }

        public async Task<Peluqueros> LoginPeluquero(string pel_correo_electronico, string pel_contrasenha) {
            var query = "SELECT * FROM Peluquero WHERE pel_correo_electronico = @pel_correo_electronico " +
                "AND pel_contrasenha = @pel_contrasenha";
            using(var conexion = _conexion.getConexion()) {
                var peluquero = await conexion.QueryFirstOrDefaultAsync<Peluqueros>(query, new { pel_correo_electronico, pel_contrasenha });
                return peluquero;
            }
        }

        public async Task<Peluqueria> LoginPeluqueria(string pelu_correo_electronico, string pelu_contrasenha) {
            var query = "SELECT * FROM Peluqueria WHERE pelu_correo_electronico = @pelu_correo_electronico " +
                "AND pelu_contrasenha = @pelu_contrasenha";
            using(var conexion = _conexion.getConexion()) {
                var peluqueria = await conexion.QueryFirstOrDefaultAsync<Peluqueria>(query, new { pelu_correo_electronico, pelu_contrasenha });
                return peluqueria;
            }
        }

        public async Task<GrupoPeluqueria> LoginGrupo(string gp_correo_electronico, string gp_contrasenha) {
            var query = "SELECT * FROM GrupoPeluqueria WHERE gp_correo_electronico = @gp_correo_electronico " +
                "AND gp_contrasenha = @gp_contrasenha";

            using(var conexion = _conexion.getConexion()) {
                var grupoPeluqueria = await conexion.QueryFirstOrDefaultAsync<GrupoPeluqueria>(query, new { gp_correo_electronico, gp_contrasenha });
                return grupoPeluqueria;
            }
        }

        // Registros ->

        public async Task RegistroUsuario(Usuarios usuarios) {
            var query = "INSERT INTO Usuarios (usu_nombre, usu_correo_electronico, usu_contrasenha) " +
                "VALUES (@usu_nombre, @usu_correo_electronico, @usu_contrasenha)";
            var parametros = new DynamicParameters();
            parametros.Add("usu_nombre", usuarios.usu_nombre, DbType.String);
            parametros.Add("usu_correo_electronico", usuarios.usu_correo_electronico, DbType.String);
            parametros.Add("usu_contrasenha", usuarios.usu_contrasenha, DbType.String);

            using(var conexion = _conexion.getConexion()) {
                await conexion.ExecuteAsync(query, parametros);
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

            using(var conexion = _conexion.getConexion()) {
                await conexion.ExecuteAsync(query, parametros);
            }
        }


        public async Task RegistroPeluqueria(Peluqueria peluqueria) {
            var query = "INSERT INTO Peluqueria (pelu_nombre, pelu_correo_electronico, pelu_contrasenha, pelu_pais, " +
                "pelu_region, pelu_ciudad, pelu_direccion, pelu_telefono, pelu_gp_id_fk) VALUES (@pelu_nombre, @pelu_correo_electronico, @pelu_contrasenha, " +
                "@pelu_pais, @pelu_region, @pelu_ciudad, @pelu_direccion, @pelu_telefono, @pelu_gp_id_fk)";

            var parametros = new DynamicParameters();
            parametros.Add("pelu_nombre", peluqueria.pelu_nombre, DbType.String);
            parametros.Add("pelu_correo_electronico", peluqueria.pelu_correo_electronico, DbType.String);
            parametros.Add("pelu_contrasenha", peluqueria.pelu_contrasenha, DbType.String);
            parametros.Add("pelu_pais", peluqueria.pelu_pais, DbType.String);
            parametros.Add("pelu_region", peluqueria.pelu_region, DbType.String);
            parametros.Add("pelu_ciudad", peluqueria.pelu_ciudad, DbType.String);
            parametros.Add("pelu_direccion", peluqueria.pelu_direccion, DbType.String);
            parametros.Add("pelu_telefono", peluqueria.pelu_telefono, DbType.String);
            parametros.Add("pelu_gp_id_fk", peluqueria.pelu_gp_id_fk, DbType.String);

            using(var conexion = _conexion.getConexion()) {
                await conexion.ExecuteAsync(query, parametros);
            }
        }

        public async Task RegistroGrupos(GrupoPeluqueria grupo) {
            var query = "INSERT INTO GrupoPeluqueria (gp_nombre, gp_correo_electronico, gp_contrasenha) VALUES " +
                "(@gp_nombre, @gp_correo_electronico, @gp_contrasenha)";

            var parametros = new DynamicParameters();
            parametros.Add("gp_nombre", grupo.gp_nombre, DbType.String);
            parametros.Add("gp_correo_electronico", grupo.gp_correo_electronico, DbType.String);
            parametros.Add("gp_contrasenha", grupo.gp_contrasenha, DbType.String);

            using(var conexion = _conexion.getConexion()) {
                await conexion.ExecuteAsync(query, parametros);
            }
        }

        // Helpers de Querys
        public async Task<int> PeluqueriaIDNombre(string pelu_nombre) {
            var query = "SELECT pelu_id FROM Peluqueria WHERE pelu_nombre = @pelu_nombre";
            using(var conexion = _conexion.getConexion()) {
                return await conexion.ExecuteScalarAsync<int>(query, new { pelu_nombre });
            }
        }

        public async Task<int> GrupoIdNombre(string gp_nombre) {
            var query = "SELECT gp_id FROM GrupoPeluqueria WHERE gp_nombre = @gp_nombre";
            using(var conexion = _conexion.getConexion()) {
                return await conexion.ExecuteScalarAsync<int>(query, new { gp_nombre });
            }
        }

        public async Task<IEnumerable<Paises>> getPaises() {
            var query = "SELECT pai_nombre FROM Paises";
            using (var conexion = _conexion.getConexion()) {
                var paises = await conexion.QueryAsync<Paises>(query);
                return paises;
            }
        }

        public async Task<IEnumerable<Region>> getRegionesPais(string pai_nombre) {
            var query = "SELECT reg_nombre FROM Region " +
                "INNER JOIN Paises AS pai ON pai.pai_id = reg_pai_id_fk " +
                "WHERE pai_nombre = @pai_nombre";

            using(var conexion = _conexion.getConexion()) {
                return await conexion.QueryAsync<Region>(query, new { pai_nombre });
            }
        }

        public async Task<GrupoPeluqueria> getGrupoPeluqueriaPeluqueriaNombre(int pelu_id) {
            var query = "SELECT gp.gp_nombre FROM GrupoPeluqueria AS gp " +
                "INNER JOIN Peluqueria AS pelu ON pelu.pelu_gp_id_fk = gp.gp_id " +
                "WHERE pelu.pelu_id = @pelu_id";

            using(var conexion = _conexion.getConexion()) {
                return await conexion.QueryFirstOrDefaultAsync<GrupoPeluqueria>(query, new { pelu_id });
            }
        }

        public async Task<IEnumerable<Servicios>> getServicios() {
            var query = "SELECT ser.ser_id, ser.ser_nombre, ser.ser_precio, cat.cat_nombre FROM Servicios AS ser " +
                "INNER JOIN Categoria AS cat ON cat.cat_id = ser_cat_id_fk";

            using(var conexion = _conexion.getConexion()) {
                var serviciosLista = await conexion.QueryAsync<Servicios>(query);
                return serviciosLista;
            }
        }

        public async Task GuardarServicios(int pelu_id, int ser_id) {
            var query = "INSERT INTO PeluqueriaServicios (pelu_ser_pelu_id_fk, pelu_ser_ser_id_fk) VALUES (@pelu_id, @ser_id)";

            using(var conexion = _conexion.getConexion()) {
                await conexion.ExecuteAsync(query, new { pelu_id, ser_id });
            }
        }

        public async Task borrarServiciosPeluqueria(int pelu_id) {
            var query = "DELETE FROM PeluqueriaServicios WHERE pelu_ser_pelu_id_fk = @pelu_id";

            using(var conexion = _conexion.getConexion()) {
                await conexion.ExecuteAsync(query, new { pelu_id });
            }
        }

        public async Task<IEnumerable<Horarios>> getHorarios() {
            var query = "SELECT * FROM Horarios";

            using(var conexion = _conexion.getConexion()) {
                var horariosLista = await conexion.QueryAsync<Horarios>(query);
                return horariosLista;
            }
        }

        public async Task<IEnumerable<Servicios>> getServiciosPeluqueria(int pelu_id) {
            var query = "SELECT ser.*, cat.cat_nombre, " +
                "CASE " +
                    "WHEN pelu_ser.pelu_ser_pelu_id_fk IS NOT NULL " +
                    "THEN 1 " +
                    "ELSE 0 " +
                "END AS ser_asociado " +
                "FROM Servicios AS ser " +
                "INNER JOIN Categoria AS cat ON cat.cat_id = ser_cat_id_fk " +
                "LEFT JOIN PeluqueriaServicios AS pelu_ser ON pelu_ser.pelu_ser_ser_id_fk = ser.ser_id AND pelu_ser.pelu_ser_pelu_id_fk = @pelu_id";

            using(var conexion = _conexion.getConexion()) {
                var serviciosLista = await conexion.QueryAsync<Servicios>(query, new { pelu_id });
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

            using(var conexion = _conexion.getConexion()) {
                var horarios = await conexion.QueryAsync<Horarios>(query, new { pelu_id });
                return horarios;
            }
        }

        public async Task GuardarHorarios(int pelu_id, int hora_id) {
            var query = "INSERT INTO PeluqueriaHorarios (pelu_hora_pelu_id_fk, pelu_hora_hora_id_fk) VALUES (@pelu_id, @hora_id)";

            using(var conexion = _conexion.getConexion()) {
                await conexion.ExecuteAsync(query, new { pelu_id, hora_id });
            }
        }

        public async Task borrarHorariosPeluqueria(int pelu_id) {
            var query = "DELETE FROM PeluqueriaHorarios WHERE pelu_hora_pelu_id_fk = @pelu_id";

            using(var conexion = _conexion.getConexion()) {
                await conexion.ExecuteAsync(query, new { pelu_id });
            }
        }

        public async Task<bool> comprobarCorreoUsuario(string usu_correo_electronico) {
            var query = "SELECT COUNT(1) FROM Usuarios WHERE usu_correo_electronico = @usu_correo_electronico";
            using(var conexion = _conexion.getConexion()) {
                return await conexion.ExecuteScalarAsync<bool>(query, new { usu_correo_electronico });
            }
        }
        public async Task<bool> comprobarCorreoPeluquero(string pel_correo_electronico) {
            var query = "SELECT COUNT(1) FROM Peluquero WHERE pel_correo_electronico = @pel_correo_electronico";
            using(var conexion = _conexion.getConexion()) {
                return await conexion.ExecuteScalarAsync<bool>(query, new { pel_correo_electronico });
            }
        }
        public async Task<bool> comprobarCorreoPeluqueria(string pelu_correo_electronico) {
            var query = "SELECT COUNT(1) FROM Peluqueria WHERE pelu_correo_electronico = @pelu_correo_electronico";
            using(var conexion = _conexion.getConexion()) {
                return await conexion.ExecuteScalarAsync<bool>(query, new { pelu_correo_electronico });
            }
        }

        public async Task<bool> comprobarCorreoGrupo(string gp_correo_electronico) {
            var query = "SELECT COUNT(1) FROM GrupoPeluqueria WHERE gp_correo_electronico = @gp_correo_electronico";
            using(var conexion = _conexion.getConexion()) {
                return await conexion.ExecuteScalarAsync<bool>(query, new { gp_correo_electronico });
            }
        }
    }
}
