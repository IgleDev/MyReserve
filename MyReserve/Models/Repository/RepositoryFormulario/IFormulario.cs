using MyReserve.Models.TablasBBDD.Peluqueros;
using MyReserve.Models.TablasBBDD.Usuarios;

namespace MyReserve.Models.Repository.RepositoryUsuarios {
    public interface IFormulario {
        Task<Usuarios> Login(string usu_correo_electronico, string usu_contrasenha);
        Task<Peluqueros> LoginPeluquero(string usu_correo_electronico, string usu_contrasenha);
        Task RegistroUsuario(Usuarios usuarios);
    }
}
