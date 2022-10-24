using System;
using System.Collections.Generic;
using System.Text;

namespace Web_App_DonChamba.Models
{
    public class Auth
    {
        public Auth() { }

        public static Usuario user { get; set; }
        public static Sucursal sucursal { get; set; }
        public string Usuario { get; set; }
        public string Contrasena { get; set; }
        public static bool Logged = false;
    }
}
