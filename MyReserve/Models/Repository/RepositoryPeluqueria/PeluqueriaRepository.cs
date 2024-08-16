using Dapper;
using MyReserve.Models.TablasBBDD.Cita;
using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Horarios;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Servicios;
using System.Data;

namespace MyReserve.Models.Repository.RepositoryPeluqueria {
    public class PeluqueriaRepository : IPeluqueria {
        private readonly Conexion _conexion;
        public PeluqueriaRepository(Conexion conexion) {
            _conexion = conexion;
        }

        public IEnumerable<Peluqueros> getPeluqueros(Peluqueria pelu) {
            var query = "SELECT pel.* FROM Peluquero AS pel " +
                "INNER JOIN Peluqueria AS pelu ON pelu.pelu_id = pel.pel_pelu_id_fk " +
                "WHERE pel.pel_pelu_id_fk = @pelu_id";

            using(var conexion = _conexion.getConexion()) {
                var peluqueros = conexion.Query<Peluqueros>(query, new { pelu.pelu_id });
                return peluqueros;
            }
        }

        public async Task<GrupoPeluqueria> GrupoIdNombre(string gp_id) {
            var query = "SELECT * FROM GrupoPeluqueria WHERE gp_id = @gp_id";
            using(var conexion = _conexion.getConexion()) {
                return await conexion.QueryFirstOrDefaultAsync<GrupoPeluqueria>(query, new { gp_id });
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

        public async Task<Peluqueros> getPeluquero(int pel_id) {
            var query = "SELECT * FROM Peluquero WHERE pel_id = @pel_id";

            using(var conexion = _conexion.getConexion()) {
                var peluquero = await conexion.QueryFirstOrDefaultAsync<Peluqueros>(query, new { pel_id });
                return peluquero;
            }
        }

        public async Task EditarPeluquero(Peluqueros peluquero) {
            var query = "UPDATE Peluquero SET pel_nombre = @pel_nombre, pel_correo_electronico = @pel_correo_electronico, " +
                "pel_contrasenha = @pel_contrasenha, pel_descripcion = @pel_descripcion, pel_experiencia = @pel_experiencia, " +
                "pel_instagram = @pel_instagram WHERE pel_id = @pel_id";
            
            var parametros = new DynamicParameters();
            parametros.Add("pel_nombre", peluquero.pel_nombre, DbType.String);
            parametros.Add("pel_correo_electronico", peluquero.pel_correo_electronico, DbType.String);
            parametros.Add("pel_contrasenha", peluquero.pel_contrasenha, DbType.String);
            parametros.Add("pel_descripcion", peluquero.pel_descripcion, DbType.String);
            parametros.Add("pel_experiencia", peluquero.pel_experiencia, DbType.Int32);
            parametros.Add("pel_instagram", peluquero.pel_instagram, DbType.String);
            parametros.Add("pel_id", peluquero.pel_id, DbType.Int32);

            using(var conexion = _conexion.getConexion()) {
                await conexion.ExecuteAsync(query, parametros);
            }
        }

        public async Task EliminarPeluqueroPeluqueria(int pel_id) {
            var queryCitas = "SELECT cita_id FROM Citas WHERE cita_pel_id_fk = @pel_id";
            var queryServiciosCita = "DELETE FROM CitasServicios WHERE citas_ser_cita_id_fk = @cita_id";
            var queryCita = "DELETE FROM Citas WHERE cita_pel_id_fk = @pel_id";
            var queryPeluquero = "DELETE FROM Peluquero WHERE pel_id = @pel_id";

            var parametros = new DynamicParameters();
            parametros.Add("pel_id", pel_id, DbType.Int32);

            using(var conexion = _conexion.getConexion()) {
                var cita_ids = await conexion.QueryAsync<int>(queryCitas, parametros);

                foreach(var cita_id in cita_ids) {
                    await conexion.ExecuteAsync(queryServiciosCita, new { cita_id });
                }

                await conexion.ExecuteAsync(queryCita, parametros);

                await conexion.ExecuteAsync(queryPeluquero, parametros);
            }

        }

        public async Task<Peluqueria> PeluqueriaIDNombre(string pelu_id) {
            var query = "SELECT * FROM Peluqueria WHERE pelu_id = @pelu_id";
            using(var conexion = _conexion.getConexion()) {
                return await conexion.QueryFirstOrDefaultAsync<Peluqueria>(query, new { pelu_id });
            }
        }

        public async Task<IEnumerable<Cita>> getCitasPeluquero(int pel_id) {
            var query = "SELECT cita.*, pel.*, hora.*, pelu.pelu_nombre, usu.usu_nombre, STRING_AGG(ser.ser_nombre, ', ') AS ser_nombres, SUM(ser.ser_precio) AS ser_precio_total " +
                "FROM Citas AS cita " +
                "INNER JOIN Usuarios AS usu ON usu.usu_id = cita.cita_usu_id_fk " +
                "INNER JOIN Peluqueria AS pelu ON pelu.pelu_id = cita.cita_pelu_id_fk " +
                "INNER JOIN Peluquero AS pel ON pel.pel_id = cita.cita_pel_id_fk " +
                "INNER JOIN Horarios AS hora ON hora.hora_id = cita.cita_hora_id_fk " +
                "LEFT JOIN CitasServicios AS citas_ser ON citas_ser.citas_ser_cita_id_fk = cita.cita_id " +
                "LEFT JOIN Servicios AS ser ON ser.ser_id = citas_ser.citas_ser_ser_id " +
                "WHERE cita.cita_pel_id_fk = @pel_id " +
                "GROUP BY cita.cita_id, cita.cita_usu_id_fk, cita.cita_pelu_id_fk, cita.cita_pel_id_fk, cita.cita_hora_id_fk, " +
                "cita.cita_fecha, pelu.pelu_nombre, usu.usu_nombre, pel.pel_id, pel.pel_nombre, pel.pel_correo_electronico, pel.pel_contrasenha, " +
                "pel.pel_descripcion, pel.pel_experiencia, pel.pel_instagram, pel.pel_pelu_id_fk, pel.pel_grupo_id_fk," +
                "hora.hora_id, hora.hora_fecha " +
                "ORDER BY cita.cita_fecha";

            using(var conexion = _conexion.getConexion()) {
                return await conexion.QueryAsync<Cita>(query, new { pel_id });
            }
        }

        public async Task<IEnumerable<Cita>> getCitasPeluqueria(int pelu_id) {
            var query = "SELECT cita.*, pel.*, hora.*, pelu.pelu_nombre, usu.usu_nombre, STRING_AGG(ser.ser_nombre, ', ') AS ser_nombres, SUM(ser.ser_precio) AS ser_precio_total " +
                "FROM Citas AS cita " +
                "INNER JOIN Usuarios AS usu ON usu.usu_id = cita.cita_usu_id_fk " +
                "INNER JOIN Peluqueria AS pelu ON pelu.pelu_id = cita.cita_pelu_id_fk " +
                "INNER JOIN Peluquero AS pel ON pel.pel_id = cita.cita_pel_id_fk " +
                "INNER JOIN Horarios AS hora ON hora.hora_id = cita.cita_hora_id_fk " +
                "LEFT JOIN CitasServicios AS citas_ser ON citas_ser.citas_ser_cita_id_fk = cita.cita_id " +
                "LEFT JOIN Servicios AS ser ON ser.ser_id = citas_ser.citas_ser_ser_id " +
                "WHERE cita.cita_pelu_id_fk = @pelu_id " +
                "GROUP BY cita.cita_id, cita.cita_usu_id_fk, cita.cita_pelu_id_fk, cita.cita_pel_id_fk, cita.cita_hora_id_fk, " +
                "cita.cita_fecha, pelu.pelu_nombre, usu.usu_nombre, pel.pel_id, pel.pel_nombre, pel.pel_correo_electronico, pel.pel_contrasenha, " +
                "pel.pel_descripcion, pel.pel_experiencia, pel.pel_instagram, pel.pel_pelu_id_fk, pel.pel_grupo_id_fk," +
                "hora.hora_id, hora.hora_fecha " +
                "ORDER BY cita.cita_fecha";

            using(var conexion = _conexion.getConexion()) {
                return await conexion.QueryAsync<Cita>(query, new { pelu_id });
            }
        }

        public async Task<bool> comprobarCorreoPeluquero(string pel_correo_electronico) {
            var query = "SELECT COUNT(1) FROM Peluquero WHERE pel_correo_electronico = @pel_correo_electronico";
            using(var conexion = _conexion.getConexion()) {
                return await conexion.ExecuteScalarAsync<bool>(query, new { pel_correo_electronico });
            }
        }

        public async Task<Peluqueria> getPeluqueria(int pelu_id) {
            var query = "SELECT * FROM Peluqueria WHERE pelu_id = @pelu_id";

            using(var conexion = _conexion.getConexion()) {
                return await conexion.QueryFirstOrDefaultAsync<Peluqueria>(query, new { pelu_id });
            }
        }
    }
}
