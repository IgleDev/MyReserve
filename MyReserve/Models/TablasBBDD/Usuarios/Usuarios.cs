namespace MyReserve.Models.TablasBBDD.Usuarios {
    public class Usuarios {
        public int usu_id { get; set; }
        public string? usu_nombre { get; set; }
        public string? usu_correo_electronico { get; set; }
        public string? usu_contrasenha { get; set; }
        public IEnumerable<MyReserve.Models.TablasBBDD.Peluqueria.Peluqueria> listaPeluqueria { get; set; } // Lista de Peluquerias del usuario.
        public IEnumerable<MyReserve.Models.TablasBBDD.Paises.Paises> listaPaises { get; set; } // Lista de Paises que tendrá el usuario.
    }
}
