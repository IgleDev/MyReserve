using Dapper;
using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Peluqueria;
using System.Data;

namespace MyReserve.Models.Repository.RepositoryGrupoPeluquerias {
    public class GrupoPeluqueriasRepository : IGrupoPeluquerias{
        private readonly Conexion _conexion;
        public GrupoPeluqueriasRepository(Conexion conexion) {
            _conexion = conexion;
        }

        public IEnumerable<Peluqueria> GetPeluquerias(GrupoPeluqueria gp) {
            var query = "SELECT pelu.* FROM Peluqueria AS pelu " +
                "INNER JOIN GrupoPeluqueria AS gp ON gp.gp_id = pelu.pelu_gp_id_fk " +
                "WHERE pelu_gp_id_fk = @gp_id";

            using(var conexion = _conexion.getConexion()) {
                var peluquerias = conexion.Query<Peluqueria>(query, new { gp.gp_id });
                return peluquerias;
            }
        }

        public async Task<Peluqueria> getPeluqueriaID(int pelu_id) {
            var query = "SELECT pelu.* FROM Peluqueria AS pelu " +
                "WHERE pelu_id = @pelu_id";

            using(var conexion = _conexion.getConexion()) {
                var peluqueria = await conexion.QueryFirstOrDefaultAsync<Peluqueria>(query, new { pelu_id });
                return peluqueria;
            }
        }

        public async Task Editar(Peluqueria peluqueria) {
            var query = "UPDATE Peluqueria SET pelu_nombre = @pelu_nombre, pelu_correo_electronico = @pelu_correo_electronico, " +
                "pelu_contrasenha = @pelu_contrasenha, pelu_direccion = @pelu_direccion, pelu_telefono = @pelu_telefono " +
                "WHERE pelu_id = @pelu_id";

            var parametros = new DynamicParameters();
            parametros.Add("pelu_nombre", peluqueria.pelu_nombre, DbType.String);
            parametros.Add("pelu_correo_electronico", peluqueria.pelu_correo_electronico, DbType.String);
            parametros.Add("pelu_contrasenha", peluqueria.pelu_contrasenha, DbType.String);
            parametros.Add("pelu_direccion", peluqueria.pelu_direccion, DbType.String);
            parametros.Add("pelu_telefono", peluqueria.pelu_telefono, DbType.Int32);
            parametros.Add("pelu_id", peluqueria.pelu_id, DbType.Int32);

            using(var conexion = _conexion.getConexion()) {
                 await conexion.ExecuteAsync(query, parametros);
            }
        }

        public async Task Eliminar(Peluqueria peluqueria) {
            var querygetPeluquero = "SELECT pel_id FROM Peluquero WHERE pel_pelu_id_fk = @pelu_id";
            var queryServiciosPeluqueria = "DELETE FROM PeluqueriaServicios WHERE pelu_ser_pelu_id_fk = @pelu_id";
            var queryPeluqueriaHorarios = "DELETE FROM PeluqueriaHorarios WHERE pelu_hora_pelu_id_fk = @pelu_id";
            var querygetCitas = "SELECT cita_id FROM Citas WHERE cita_pelu_id_fk = @pelu_id";
            var queryServiciosCita = "DELETE FROM CitasServicios WHERE citas_ser_cita_id_fk = @cita_id";
            var queryCita = "DELETE FROM Citas WHERE cita_pelu_id_fk = @pelu_id";
            var queryServicio = "DELETE FROM Servicios WHERE ser_pelu_id_fk = @pelu_id";
            var queryPeluqueria = "DELETE FROM Peluqueria WHERE pelu_id = @pelu_id";
            var queryPeluquero = "DELETE FROM Peluquero WHERE pel_id = @pel_id";

            var parametros = new DynamicParameters();
            parametros.Add("pelu_id", peluqueria.pelu_id, DbType.Int32);

            using(var conexion = _conexion.getConexion()) {
                var cita_ids = await conexion.QueryAsync<int>(querygetCitas, parametros);
                foreach(var cita_id in cita_ids) {
                    await conexion.ExecuteAsync(queryServiciosCita, new { cita_id });
                }

                await conexion.ExecuteAsync(queryCita, parametros);
                await conexion.ExecuteAsync(queryServiciosPeluqueria, parametros);

                var pel_ids = await conexion.QueryAsync<int?>(querygetPeluquero, parametros);
                foreach(var pel_id in pel_ids) {
                    await conexion.ExecuteAsync(queryPeluquero, new { pel_id });
                }

                await conexion.ExecuteAsync(queryPeluqueriaHorarios, parametros);
                await conexion.ExecuteAsync(queryServicio, parametros);
                await conexion.ExecuteAsync(queryPeluqueria, parametros);

            }
        }


        public async Task<bool> comprobarCorreoGrupo(string gp_correo_electronico) {
            var query = "SELECT COUNT(1) FROM GrupoPeluqueria WHERE gp_correo_electronico = @gp_correo_electronico";
            using(var conexion = _conexion.getConexion()) {
                return await conexion.ExecuteScalarAsync<bool>(query, new { gp_correo_electronico });
            }
        }

        public async Task<bool> comprobarCorreoPeluquerias(string pelu_correo_electronico) {
            var query = "SELECT COUNT(1) FROM Peluqueria WHERE pelu_correo_electronico = @pelu_correo_electronico";
            using(var conexion = _conexion.getConexion()) {
                return await conexion.ExecuteScalarAsync<bool>(query, new { pelu_correo_electronico });
            }
        }

        public async Task<GrupoPeluqueria> getGrupoPeluqueria(int gp_id) {
            var query = "SELECT * FROM GrupoPeluqueria WHERE gp_id = @gp_id";

            using(var conexion = _conexion.getConexion()) {
                var grupo = await conexion.QueryFirstOrDefaultAsync<GrupoPeluqueria>(query, new { gp_id });
                return grupo;
            }
        }

        public async Task EditarGrupo(GrupoPeluqueria gp) {
            var query = "UPDATE GrupoPeluqueria SET gp_nombre = @gp_nombre, gp_correo_electronico = @gp_correo_electronico, " +
                "gp_contrasenha = @gp_contrasenha WHERE gp_id = @gp_id";

            var parametros = new DynamicParameters();
            parametros.Add("gp_nombre", gp.gp_nombre, DbType.String);
            parametros.Add("gp_correo_electronico", gp.gp_correo_electronico, DbType.String);
            parametros.Add("gp_contrasenha", gp.gp_contrasenha, DbType.String);
            parametros.Add("gp_id", gp.gp_id, DbType.Int32);

            using(var conexion = _conexion.getConexion()) {
                await conexion.ExecuteAsync(query, parametros);
            }
        }

        public async Task EliminarGrupo(GrupoPeluqueria gp) {
            var querygetPeluquerias = "SELECT pelu_id FROM Peluqueria WHERE pelu_gp_id_fk = @gp_id";
            var querygetPeluquero = "SELECT pel_id FROM Peluquero WHERE pel_grupo_id_fk = @gp_id";
            var querygetCitasPeluqueria = "SELECT cita_id FROM Citas WHERE cita_pelu_id_fk = @pelu_id";
            var querygetCitasPeluquero = "SELECT cita_id FROM Citas WHERE cita_pel_id_fk = @pel_id";
            var querygetServiciosPeluqueria = "SELECT ser_id FROM Servicios WHERE ser_pelu_id_fk = @pelu_id";
            var queryServiciosCita = "DELETE FROM CitasServicios WHERE citas_ser_cita_id_fk = @cita_id";
            var queryCita = "DELETE FROM Citas WHERE cita_id = @cita_id";
            var queryServiciosPeluqueria = "DELETE FROM Servicios WHERE ser_id = @ser_id";
            var queryPeluqueriaServicios = "DELETE FROM PeluqueriaServicios WHERE pelu_ser_pelu_id_fk = @pelu_id";
            var queryPeluqueriaHorarios = "DELETE FROM PeluqueriaHorarios WHERE pelu_hora_pelu_id_fk = @pelu_id";
            var queryPeluquero = "DELETE FROM Peluquero WHERE pel_id = @pel_id";
            var queryPeluquerias = "DELETE FROM Peluqueria WHERE pelu_gp_id_fk = @gp_id";
            var queryGrupo = "DELETE FROM GrupoPeluqueria WHERE gp_id = @gp_id";

            var parametros = new DynamicParameters();
            parametros.Add("gp_id", gp.gp_id, DbType.Int32);

            using(var conexion = _conexion.getConexion()) {
                var peluquerias = await conexion.QueryAsync<int>(querygetPeluquerias, parametros);
                foreach(var pelu_id in peluquerias) {
                    var citasPeluqueria = await conexion.QueryAsync<int>(querygetCitasPeluqueria, new { pelu_id });
                    foreach(var cita_id in citasPeluqueria) {
                        await conexion.ExecuteAsync(queryServiciosCita, new { cita_id });
                        await conexion.ExecuteAsync(queryCita, new { cita_id });
                    }

                    await conexion.ExecuteAsync(queryPeluqueriaServicios, new { pelu_id });

                    var serviciosPeluqueria = await conexion.QueryAsync<int>(querygetServiciosPeluqueria, new { pelu_id });
                    foreach(var ser_id in serviciosPeluqueria) {
                        await conexion.ExecuteAsync(queryServiciosPeluqueria, new { ser_id });
                    }

                    await conexion.ExecuteAsync(queryPeluqueriaHorarios, new { pelu_id });
                }

                var peluqueros = await conexion.QueryAsync<int>(querygetPeluquero, parametros);
                foreach(var pel_id in peluqueros) {
                    var citasPeluquero = await conexion.QueryAsync<int>(querygetCitasPeluquero, new { pel_id });
                    foreach(var cita_id in citasPeluquero) {
                        await conexion.ExecuteAsync(queryServiciosCita, new { cita_id });
                        await conexion.ExecuteAsync(queryCita, new { cita_id });
                    }
                    await conexion.ExecuteAsync(queryPeluquero, new { pel_id });
                }

                await conexion.ExecuteAsync(queryPeluquerias, parametros);
                await conexion.ExecuteAsync(queryGrupo, parametros);
            }
        }

    }
}