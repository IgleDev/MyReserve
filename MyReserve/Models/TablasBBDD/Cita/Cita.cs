namespace MyReserve.Models.TablasBBDD.Cita {
    public class Cita {
        public int cita_id { get; set; }
        public int cita_usu_id_fk { get; set; }
        public int cita_pelu_id_fk { get; set; }
        public int cita_pel_id_fk { get; set; }
        public int cita_hora_id_fk { get; set; }
        public DateTime cita_fecha { get; set; }
        public List<int> servicios { get; set; }
    }
}
