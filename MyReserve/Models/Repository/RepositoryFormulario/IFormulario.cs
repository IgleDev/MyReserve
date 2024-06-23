using MyReserve.Models.TablasBBDD.GrupoPeluqueria;
using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Usuarios;

namespace MyReserve.Models.Repository.RepositoryUsuarios {
    public interface IFormulario {

        // Logins ->
        Task<Usuarios> Login(string usu_correo_electronico, string usu_contrasenha);
        Task<Peluqueros> LoginPeluquero(string pel_correo_electronico, string pel_contrasenha);
        Task<Peluqueria> LoginPeluqueria(string pelu_correo_electronico, string pelu_contrasenha);
        Task<GrupoPeluqueria> LoginGrupo(string gp_correo_electronico, string gp_contrasenha);

        // Registros ->
        Task RegistroUsuario(Usuarios usuarios);
        Task RegistroPeluqueros(Peluqueros peluqueros);
        Task RegistroPeluqueria(Peluqueria peluqueria);
        Task RegistroGrupos(GrupoPeluqueria grupo);

        // Helpers de Querys
        Task<int> PeluqueriaIDNombre(string pelu_nombre);
        Task<int> GrupoIdNombre(string gp_nombre);
    }
}
