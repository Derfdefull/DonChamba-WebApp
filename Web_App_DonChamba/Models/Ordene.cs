using System;
using System.Collections.Generic;

namespace WebAPIDonChamba.Models
{
    public partial class Ordene
    {
        public Ordene()
        {
             
        }

        public int PkIdOrden { get; set; }
        public int FkIdUsuario { get; set; }
        public string Comentario { get; set; }
        public byte Estado { get; set; }
        public decimal Total { get; set; }

      
    }
}
