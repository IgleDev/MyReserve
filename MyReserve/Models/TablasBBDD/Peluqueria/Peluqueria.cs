using Humanizer;

namespace MyReserve.Models.TablasBBDD.Peluqueria {
    public class Peluqueria {
        public int pelu_id { get; set; }
        public string pelu_nombre { get; set; }
        public string pelu_correo_electronico { get; set; }
        public string pelu_contrasenha { get; set; }
        public string pelu_pais { get; set; }
        public string pelu_region { get; set; }
        public string pelu_ciudad {  get; set; }
        public string pelu_direccion { get; set; }
        public string pelu_telefono { get; set; }
        public string pelu_gp_id_fk { get; set; }
        public MyReserve.Models.TablasBBDD.GrupoPeluqueria.GrupoPeluqueria grupoPeluqueria { get; set; }
        public IEnumerable<MyReserve.Models.TablasBBDD.Peluqueros.Peluqueros> peluqueros { get; set; }
        public IEnumerable<MyReserve.Models.TablasBBDD.Paises.Paises> listaPaises { get; set; }
        public IEnumerable<MyReserve.Models.TablasBBDD.Servicios.Servicios> Servicios { get; set; }
    }
}
