﻿using Dapper;
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
            var queryCitas = "SELECT cita_id FROM Citas WHERE cita_pelu_id_fk = @pelu_id";
            var queryServiciosCita = "DELETE FROM CitasServicios WHERE citas_ser_cita_id_fk = @cita_id";
            var queryCita = "DELETE FROM Citas WHERE cita_pelu_id_fk = @pelu_id";
            var queryPeluqueria = "DELETE FROM Peluqueria WHERE pelu_id = @pelu_id";
            var parametros = new DynamicParameters();
            parametros.Add("pelu_id", peluqueria.pelu_id, DbType.Int32);

            using(var conexion = _conexion.getConexion()) {
                var cita_ids = await conexion.QueryAsync<int>(queryCitas, parametros);

                foreach(var cita_id in cita_ids) {
                    await conexion.ExecuteAsync(queryServiciosCita, new { cita_id });
                }

                await conexion.ExecuteAsync(queryCita, parametros);
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
            var queryPeluquerias = "DELETE FROM Peluqueria WHERE pelu_gp_id_fk = @gp_id";
            var queryGrupo = "DELETE FROM GrupoPeluqueria WHERE gp_id = @gp_id";

            var parametros = new DynamicParameters();
            parametros.Add("gp_id", gp.gp_id, DbType.Int32);

            using(var conexion = _conexion.getConexion()) {
                await conexion.ExecuteAsync(queryPeluquerias, parametros);
                await conexion.ExecuteAsync(queryGrupo, parametros);
            }
        }

    }
}
