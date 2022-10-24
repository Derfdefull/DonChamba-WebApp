using System;
using System.Collections.Generic;

namespace WebAPIDonChamba.Models
{
    public partial class OrdenesDetalle
    {
        public int PkIdDetalle { get; set; }
        public int FkIdOrden { get; set; }
        public int FkIdProducto { get; set; }
        public decimal Preciounidad { get; set; }
        public decimal Cantidad { get; set; }
        public decimal Subtotal { get; set; } 
    }
}
