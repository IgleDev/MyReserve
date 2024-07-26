namespace MyReserve.Models.TablasBBDD.Servicios {
    public class Servicios {
        public int ser_id {  get; set; }
        public string? ser_nombre { get; set; }
        public int ser_precio { get; set; }
        public string? ser_pelu_id_fk { get; set; }
        public string? ser_cat_id_fk { get; set; }
        public int ser_asociado { get; set; }
        public string? cat_nombre { get; set; }
    }
}
