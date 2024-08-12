using Dapper;
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

        public IEnumerable<Peluqueros> GetPeluqueros(Peluqueria pelu) {
            var query = "SELECT pel.* FROM Peluquero AS pel " +
                "INNER JOIN Peluqueria AS pelu ON pelu.pelu_id = pel.pel_pelu_id_fk " +
                "WHERE pel.pel_pelu_id_fk = @pelu_id";

            using(var conexion = _conexion.getConexion()) {
                var peluqueros = conexion.Query<Peluqueros>(query, new { pelu.pelu_id });
                return peluqueros;
            }
        }

        public GrupoPeluqueria GrupoIdNombre(string gp_id) {
            var query = "SELECT * FROM GrupoPeluqueria WHERE gp_id = @gp_id";
            using(var conexion = _conexion.getConexion()) {
                return conexion.QueryFirstOrDefault<GrupoPeluqueria>(query, new { gp_id });
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
            var query = "DELETE FROM Peluquero WHERE pel_id = @pel_id";

            var parametros = new DynamicParameters();
            parametros.Add("pel_id", pel_id, DbType.Int32);

            using(var conexion = _conexion.getConexion()) {
               await conexion.ExecuteAsync(query, parametros);
            }

        }
    }
}
