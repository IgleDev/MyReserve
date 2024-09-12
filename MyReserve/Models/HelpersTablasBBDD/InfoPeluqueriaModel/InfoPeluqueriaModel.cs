using MyReserve.Models.TablasBBDD.Peluqueria;
using MyReserve.Models.TablasBBDD.Peluqueros;

namespace MyReserve.Models.HelpersTablasBBDD.InfoPeluqueriaModel {
    public class InfoPeluqueriaModel {
        public Peluqueria peluqueriaInfo { get; set; }
        public int usu_id { get; set; }
        public IEnumerable<Peluqueros> peluquerosInfo { get; set; }
        public Peluqueros peluqueroInfo { get; set; }
    }
}
