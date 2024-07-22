﻿using Dapper;
using MyReserve.Models.TablasBBDD.Paises;
using MyReserve.Models.TablasBBDD.Usuarios;
using MyReserve.Models.TablasBBDD.Region;
using System.Data;
using MyReserve.Models.TablasBBDD.Peluqueria;

namespace MyReserve.Models.Repository.RepositoryUsuario {
    public class IInfoUsuariosRepository : IInfoUsuarios{
        private readonly Conexion _conexion;

        public IInfoUsuariosRepository(Conexion conexion) {
            _conexion = conexion;
        }

        public IEnumerable<Paises> getPaises() {
            var query = "SELECT pai_nombre FROM Paises";
            using(var connection = _conexion.getConexion()) {
                var paises = connection.Query<Paises>(query);
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
            using(var connection = _conexion.getConexion()) {
               await connection.ExecuteAsync(query, parametros);
            }
        }

        public async Task Eliminar(int usu_id) {
            var query = "DELETE FROM Usuarios WHERE usu_id = @usu_id";
            var parametros = new DynamicParameters();
            parametros.Add("usu_id", usu_id, DbType.Int32);

            using(var connection = _conexion.getConexion()) {
                await connection.ExecuteAsync(query, parametros);
            }
        }

        public async Task<IEnumerable<Region>> getRegionesPais(string pai_nombre) {
            var query = "SELECT reg_nombre FROM Region " +
                "INNER JOIN Paises AS pai ON pai.pai_id = reg_pai_id_fk " +
                "WHERE pai_nombre = @pai_nombre";

            using(var connection = _conexion.getConexion()) {
                return await connection.QueryAsync<Region>(query, new { pai_nombre = pai_nombre });
            }
        }

        public async Task<IEnumerable<Peluqueria>> getPeluqueriasFiltro(string pelu_pais, string pelu_region, string pelu_ciudad) {
            var query = "SELECT * FROM Peluqueria " +
                "WHERE pelu_pais = @pelu_pais AND pelu_region = @pelu_region AND pelu_ciudad = @pelu_ciudad";

            using(var connection = _conexion.getConexion()) {
                return await connection.QueryAsync<Peluqueria>(query, new { pelu_pais, pelu_region, pelu_ciudad });
            }
        }

        public async Task<Peluqueria> getPeluqueriaID(int pelu_id) {
            var query = "SELECT * FROM Peluqueria WHERE pelu_id = @pelu_id";

            using(var connection = _conexion.getConexion()) {
                var peluqueria = connection.QueryFirstOrDefault<Peluqueria>(query, new { pelu_id });
                return peluqueria;
            }
        }
    }
}
