using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebAPIDonChamba.Models;

namespace Web_App_DonChamba.Services
{
    public partial class Categories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public  static object getCategories()
        {
            APIHelper apiHelper = new APIHelper();
            object json = new { data =  apiHelper.getAsync<Categoria>("Categorias") };
            return json;
        }

        [WebMethod]
        public static object deleteCategories(string id)
        {
            APIHelper apiHelper = new APIHelper();
            object json = new { result = apiHelper.deleteAsync("Categorias", id) };
            return  json;
        }

        [WebMethod]
        public static object saveCategories(string Nombre)
        {
            APIHelper apiHelper = new APIHelper();
            object json = 
                new { 
                result = apiHelper.saveAsync("Categorias", 
                new Categoria(){ PkIdCategoria = 0, Nombre = Nombre} ) };

            return json;
        }

        [WebMethod]
        public static object editCategories(string PkIdCategoria, string Nombre)
        {
            APIHelper apiHelper = new APIHelper();
            object json =
                new
                {
                  result = apiHelper.editAsync("Categorias", 
                  new Categoria() { PkIdCategoria = int.Parse(PkIdCategoria), Nombre = Nombre }
                  ,PkIdCategoria)
                };

            return json;
        }

    }
}