using System;
using System.Collections.Generic;
using System.Text;

namespace Web_App_DonChamba.Models
{
    public class Sucursal
    {
        public Sucursal()
        {

        }

        public int PkIdSucursal { get; set; }
        public string Nombre { get; set; }
        public string Direccion { get; set; } 
        public string Telefono { get; set; } 


    }
}
