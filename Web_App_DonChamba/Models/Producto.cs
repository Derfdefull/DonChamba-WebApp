using System;
using System.Collections.Generic;

namespace WebAPIDonChamba.Models
{
    public partial class Producto
    {
        public Producto()
        {
            
        }

        public int PkIdProducto { get; set; }
        public int FkIdCategoria { get; set; }
        public string Nombre { get; set; } 
        public string Descripcion { get; set; }
        public int Estado { get; set; }
        public string Imagen { get; set; } 
        public decimal Precio { get; set; }
        public decimal Promocion { get; set; }
    }
}
