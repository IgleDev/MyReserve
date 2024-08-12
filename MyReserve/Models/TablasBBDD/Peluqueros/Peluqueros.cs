using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace MyReserve.Models.TablasBBDD.Peluqueros {
    public class Peluqueros {
        public int pel_id {  get; set; }
        
        [Required]
        public string? pel_nombre { get; set; }
        
        [Required]
        public string? pel_correo_electronico { get; set; }
        
        [Required]
        public string? pel_contrasenha { get; set; }
        public string? pel_descripcion { get; set; }

        [Required]
        public int pel_experiencia { get; set; }

        [Required]
        public string? pel_instagram { get; set; }

        [Required]
        public string? pel_pelu_id_fk { get; set; }

        [Required]
        public string? pel_grupo_id_fk { get; set; }

        public MyReserve.Models.TablasBBDD.Peluqueria.Peluqueria? peluqueria { get; set; }
        public MyReserve.Models.TablasBBDD.GrupoPeluqueria.GrupoPeluqueria? grupoPeluqueria { get; set; }
    }
}
