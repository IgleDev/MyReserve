using Dapper;
using MyReserve.Models.TablasBBDD.Paises;
using MyReserve.Models.TablasBBDD.Usuarios;
using MyReserve.Models.TablasBBDD.Region;
using System.Data;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Horarios;
using MyReserve.Models.TablasBBDD.Servicios;
using MyReserve.Models.TablasBBDD.Cita;

namespace MyReserve.Models.Repository.RepositoryUsuario {
    public class IInfoUsuariosRepository : IInfoUsuarios{
        private readonly Conexion _conexion;

        public IInfoUsuariosRepository(Conexion conexion) {
            _conexion = conexion;
        }

        public IEnumerable<Paises> getPaises() {
            var query = "SELECT pai_nombre FROM Paises";
            using(var conexion = _conexion.getConexion()) {
                var paises = conexion.Query<Paises>(query);
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
            using(var conexion = _conexion.getConexion()) {
               await conexion.ExecuteAsync(query, parametros);
            }
        }

        public async Task Eliminar(int usu_id) {
            var query = "DELETE FROM Usuarios WHERE usu_id = @usu_id";
            var parametros = new DynamicParameters();
            parametros.Add("usu_id", usu_id, DbType.Int32);

            using(var conexion = _conexion.getConexion()) {
                await conexion.ExecuteAsync(query, parametros);
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

        public async Task<IEnumerable<Peluqueria>> getPeluqueriasFiltro(string pelu_pais, string pelu_region, string pelu_ciudad) {
            var query = "SELECT * FROM Peluqueria " +
                "WHERE pelu_pais = @pelu_pais AND pelu_region = @pelu_region AND pelu_ciudad = @pelu_ciudad";

            using(var conexion = _conexion.getConexion()) {
                return await conexion.QueryAsync<Peluqueria>(query, new { pelu_pais, pelu_region, pelu_ciudad });
            }
        }

        public async Task<Peluqueria> getPeluqueriaID(int pelu_id) {
            var query = "SELECT * FROM Peluqueria WHERE pelu_id = @pelu_id";

            using(var conexion = _conexion.getConexion()) {
                var peluqueria = conexion.QueryFirstOrDefault<Peluqueria>(query, new { pelu_id });
                return peluqueria;
            }
        }

        public async Task<IEnumerable<Peluqueros>> getPeluquerosPeluqueriaID(int pelu_id) {
            var query = "SELECT pel.* FROM Peluquero AS pel " +
                "INNER JOIN Peluqueria AS pelu ON pelu.pelu_id = pel.pel_pelu_id_fk " +
                "WHERE pelu_id = @pelu_id";

            using(var conexion = _conexion.getConexion()) {
                return await conexion.QueryAsync<Peluqueros>(query, new { pelu_id });
            }
        }

        public async Task<IEnumerable<Servicios>> getServiciosPeluqueria(int pelu_id) {
            var query = "SELECT ser.ser_id, ser.ser_nombre, ser.ser_precio, cat.cat_nombre, " +
                "CASE " +
                    "WHEN pelu_ser.pelu_ser_pelu_id_fk IS NOT NULL " +
                    "THEN 1 " +
                    "ELSE 0 " +
                "END AS ser_asociado " +
                "FROM Servicios AS ser " +
                "INNER JOIN Categoria AS cat ON cat.cat_id = ser.ser_cat_id_fk " +
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

        public async Task<int> GuardarCita(Cita cita) {
            var query = "INSERT INTO Citas (cita_usu_id_fk, cita_pel_id_fk, cita_pelu_id_fk, cita_hora_id_fk, cita_fecha) " +
                "OUTPUT INSERTED.cita_id " +
                "VALUES (@cita_usu_id_fk, @cita_pel_id_fk, @cita_pelu_id_fk, @cita_hora_id_fk, @cita_fecha)";

            using(var conexion = _conexion.getConexion()) {
                return await conexion.ExecuteScalarAsync<int>(query, new { cita.cita_usu_id_fk, cita.cita_pel_id_fk, cita.cita_pelu_id_fk, cita.cita_hora_id_fk, cita.cita_fecha });
            }
        }

        public async Task GuardarCitasServicios(int cita_id, List<int> servicios) {
            var query = "INSERT INTO CitasServicios (citas_ser_cita_id_fk, citas_ser_ser_id) VALUES (@cita_id, @ser_id)";

            using(var conexion = _conexion.getConexion()) {
                foreach(var ser_id in servicios) {
                    await conexion.ExecuteAsync(query, new { cita_id, ser_id });
                }
            }
        }

        public async Task<IEnumerable<Horarios>> getHorariosDisponibles(int pelu_id, DateTime fechaCita) {
            var query = "SELECT hora.hora_id, hora.hora_fecha FROM Horarios AS hora " +
                "INNER JOIN PeluqueriaHorarios AS pelu_hora ON hora.hora_id = pelu_hora.pelu_hora_hora_id_fk " +
                "AND pelu_hora.pelu_hora_pelu_id_fk = @pelu_id AND pelu_hora.hora_reservado IS NULL " +
                "WHERE hora.hora_id NOT IN (SELECT cita_hora_id_fk FROM Citas " +
                "WHERE cita_pelu_id_fk = @pelu_id AND cita_fecha = @fechaCita)";
            
            using(var conexion = _conexion.getConexion()) {
                return await conexion.QueryAsync<Horarios>(query, new { pelu_id, fechaCita });
            }
        }

        public async Task<IEnumerable<Cita>> getCitasUsuario(int usu_id) {
            var query = "SELECT cita.*, pel.*, hora.*, pelu.pelu_nombre, usu.usu_nombre, STRING_AGG(ser.ser_nombre, ', ') AS ser_nombres, SUM(ser.ser_precio) AS ser_precio_total " +
                "FROM Citas AS cita " +
                "INNER JOIN Usuarios AS usu ON usu.usu_id = cita.cita_usu_id_fk " +
                "INNER JOIN Peluqueria AS pelu ON pelu.pelu_id = cita.cita_pelu_id_fk " +
                "INNER JOIN Peluquero AS pel ON pel.pel_id = cita.cita_pel_id_fk " +
                "INNER JOIN Horarios AS hora ON hora.hora_id = cita.cita_hora_id_fk " +
                "LEFT JOIN CitasServicios AS citas_ser ON citas_ser.citas_ser_cita_id_fk = cita.cita_id " +
                "LEFT JOIN Servicios AS ser ON ser.ser_id = citas_ser.citas_ser_ser_id " +
                "WHERE cita.cita_usu_id_fk = @usu_id " +
                "GROUP BY cita.cita_id, cita.cita_usu_id_fk, cita.cita_pelu_id_fk, cita.cita_pel_id_fk, cita.cita_hora_id_fk, " +
                "cita.cita_fecha, pelu.pelu_nombre, usu.usu_nombre, pel.pel_id, pel.pel_nombre, pel.pel_correo_electronico, pel.pel_contrasenha, " +
                "pel.pel_descripcion, pel.pel_experiencia, pel.pel_instagram, pel.pel_pelu_id_fk, pel.pel_grupo_id_fk," +
                "hora.hora_id, hora.hora_fecha " +
                "ORDER BY cita.cita_fecha";

            using(var conexion = _conexion.getConexion()) {
                return await conexion.QueryAsync<Cita>(query, new { usu_id });
            }
        }

        public async Task EliminarCita(int cita_id) {
            var queryCitasServicios = "DELETE FROM CitasServicios WHERE citas_ser_cita_id_fk = @cita_id";
            var queryCita = "DELETE FROM Citas WHERE cita_id = @cita_id";

            using(var conexion = _conexion.getConexion()) {
                var parametros = new DynamicParameters();
                parametros.Add("cita_id", cita_id, DbType.Int32);

                await conexion.ExecuteAsync(queryCitasServicios, parametros);
                await conexion.ExecuteAsync(queryCita, parametros);
            }
        }

        public async Task<bool> comprobarCorreoUsuario(string usu_correo_electronico) {
            var query = "SELECT COUNT(1) FROM Usuarios WHERE usu_correo_electronico = @usu_correo_electronico";
            using(var conexion = _conexion.getConexion()) {
                return await conexion.ExecuteScalarAsync<bool>(query, new { usu_correo_electronico });
            }
        }
    }
}
