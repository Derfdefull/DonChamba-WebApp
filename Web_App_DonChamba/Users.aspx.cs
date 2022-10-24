using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web_App_DonChamba.Models;
using Web_App_DonChamba.Services;

namespace Web_App_DonChamba
{
    public partial class Users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static object getUsers()
        {
            APIHelper apiHelper = new APIHelper();
            object json = new { data = apiHelper.getAsync<Usuario>("Usuarios") };
            return json;
        }

        [WebMethod]
        public static object deleteUsers(string id)
        {
            APIHelper apiHelper = new APIHelper();
            object json = new { result = apiHelper.deleteAsync("Usuarios", id) };
            return json;
        }

        [WebMethod]
        public static object saveUsers(string FkIdSucursal, string Nombres, string Apellidos, string Celular, string Telefono, string Usuario, string Contrasena)
        {
            APIHelper apiHelper = new APIHelper();
            object json =
                new
                {
                    result = apiHelper.saveAsync("Usuarios",
                new Usuario()
                {
                    PkIdUsuario = 0,
                    FkIdSucursal = int.Parse(FkIdSucursal),
                    Nombres = Nombres,
                    Apellidos = Apellidos,
                    Celular = Celular,
                    Telefono = Telefono,
                    Usuario1 = Usuario,
                    Contrasena = Contrasena
                })};

            return json;
        }

        [WebMethod]
        public static object editUsers(string PkIdUsuario, string FkIdSucursal, string Nombres, string Apellidos, string Celular, string Telefono, string Usuario,string Contrasena)
        {
            APIHelper apiHelper = new APIHelper();
            object json =
                new
                {
                    result = apiHelper.editAsync("Usuarios",
                  new Usuario()
                  {
                      PkIdUsuario = int.Parse(PkIdUsuario),
                      FkIdSucursal = int.Parse(FkIdSucursal),
                      Nombres = Nombres,
                      Apellidos = Apellidos,
                      Celular = Celular,
                      Telefono = Telefono,
                      Usuario1 = Usuario,
                      Contrasena = Contrasena
                  }
                  , PkIdUsuario)
                };

            return json;
        }
    }
}