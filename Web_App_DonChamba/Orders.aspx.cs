using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web_App_DonChamba.Models;
using Web_App_DonChamba.Services;
using WebAPIDonChamba.Models;

namespace Web_App_DonChamba
{
    public partial class Orders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public static object getOrders()
        {
            APIHelper apiHelper = new APIHelper();
            object json = new { data = apiHelper.getAsync<Ordene>("Ordenes") };
            return json;
        }
  
        
        [WebMethod]
        public static object editOrders(string PkIdOrden, string FkIdUsuario, string Comentario, string Estado, string Total)
        {
            APIHelper apiHelper = new APIHelper();
            var orden = new Ordene()
            {
                PkIdOrden = int.Parse(PkIdOrden),
                FkIdUsuario = int.Parse(FkIdUsuario),
                Comentario = Comentario,
                Estado = byte.Parse(Estado),
                Total = decimal.Parse(Total)
            };
            object json =
                new
                {
                  result = apiHelper.editAsync("Ordenes", orden, PkIdOrden) 
                };

            return json;
        }

        [WebMethod]
        public static object getOrderDetails (string PkIdOrden)
        {
            APIHelper apiHelper = new APIHelper();
             
            object json =
                new
                {
                    result = apiHelper.getAsync<OrdenesDetalle>(String.Format("OrdenesDetalles/byOrder/{0}", PkIdOrden))
                };

            return json;
        }

    }
}