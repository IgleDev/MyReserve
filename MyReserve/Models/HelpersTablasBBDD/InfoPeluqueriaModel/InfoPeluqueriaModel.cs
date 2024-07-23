using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;

namespace MyReserve.Models.HelpersTablasBBDD.InfoPeluqueriaModel {
    public class InfoPeluqueriaModel {
        public Peluqueria peluqueriaInfo { get; set; }
        public IEnumerable<Peluqueros> peluqueroInfo { get; set; }
        public string usu_nombre { get; set; }
    }
}
