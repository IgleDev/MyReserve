namespace MyReserve.Models.TablasBBDD.Peluqueros {
    public class Peluqueros {
        public int pel_id {  get; set; }
        public string? pel_nombre { get; set; }
        public string? pel_correo_electronico { get; set; }
        public string? pel_contrasenha { get; set; }
        public int pel_experiencia { get; set; }
        public string? pel_instagram { get; set; }
        public string? pel_pelu_id_fk { get; set; }
        public string? pel_grupo_id_fk { get; set; }
    }
}
