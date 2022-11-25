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
    public partial class Companies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static object getCompanies()
        {
            APIHelper apiHelper = new APIHelper();
            object json = new { data = apiHelper.getAsync<Sucursal>("Sucursales") };
            return json;
        }

        [WebMethod]
        public static object deleteCompanies(string id)
        {
            APIHelper apiHelper = new APIHelper();
            object json = new { result = apiHelper.deleteAsync("Sucursales", id) };
            return json;
        }

        [WebMethod]
        public static object saveCompanies(string Nombre, string Direccion, string Telefono, decimal Comision)
        {
            APIHelper apiHelper = new APIHelper();
            object json =
                new
                {
                    result = apiHelper.saveAsync("Sucursales",
                new Sucursal() { PkIdSucursal = 0, Nombre = Nombre, Direccion= Direccion, Telefono = Telefono, Comision = Comision})
                };

            return json;
        }

        [WebMethod]
        public static object editCompanies(string PkIdSucursal, string Nombre, string Direccion, string Telefono, decimal Comision)
        {
            APIHelper apiHelper = new APIHelper();
            object json =
                new
                {
                    result = apiHelper.editAsync("Sucursales",
                  new Sucursal() { PkIdSucursal = int.Parse(PkIdSucursal), Nombre = Nombre, 
                                    Direccion = Direccion, Telefono = Telefono, Comision = Comision  }
                  , PkIdSucursal)
                };

            return json;
        }
    }
}