using Humanizer;

namespace MyReserve.Models.TablasBBDD.Peluqueria {
    public class Peluqueria {
        public int pelu_id { get; set; }
        public string pelu_nombre { get; set; }
        public string pelu_correo_electronico { get; set; }
        public string pelu_contrasenha { get; set; }
        public string pelu_pais { get; set; }
        public string pelu_ciudad { get; set; }
        public string pelu_telefono { get; set; }
        public string pelu_gp_id_fk { get; set; }
    }
}
