﻿
namespace MyReserve.Models.TablasBBDD.GrupoPeluqueria {
    public class GrupoPeluqueria {
        public int gp_id { get; set; }
        public string gp_nombre { get; set; }
        public string gp_correo_electronico { get; set; }
        public string gp_contrasenha{ get; set; }
        public IEnumerable<MyReserve.Models.TablasBBDD.Peluqueria.Peluqueria> peluquerias { get; set; }
    }
}
