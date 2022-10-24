using System;
using System.Collections.Generic;
using System.IO;
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
    public partial class Products : System.Web.UI.Page
    {
        public static string ServerURL;
        protected void Page_Load(object sender, EventArgs e)
        {
            ServerURL = Server.MapPath("~/Assets/ProductsIMG/");
        }
         
        [WebMethod]
        public static object saveImg(string imgdata)
        { 
            try
            {
                imgdata = imgdata.Replace("data:image/png;base64,", "");
                imgdata = imgdata.Replace("data:image/jpg;base64,", "");
                imgdata = imgdata.Replace("data:image/jpeg;base64,", "");
                string fileName = DateTime.Now.Ticks.ToString() + ".jpeg";
                string fileNameWitPath = Path.Combine(ServerURL, fileName);
                using (FileStream fs = new FileStream(fileNameWitPath, FileMode.Create))
                {
                    using (BinaryWriter bw = new BinaryWriter(fs))
                    {
                        byte[] data = Convert.FromBase64String(imgdata);
                        bw.Write(data);
                        bw.Close();
                    }
                    fs.Close();
                }
                
                return new { data = "true", path = "https://localhost:44373/Assets/ProductsIMG/" + fileName };
            }
            catch (Exception ex)
            {
                return new { data = "false" };
            }
            
            
              
        }


        [WebMethod]
        public static object getProducts()
        {
            APIHelper apiHelper = new APIHelper();
            object json = new { data = apiHelper.getAsync<Producto>("Productoes") };
            return json;
        }

        [WebMethod]
        public static object deleteProducts(string id)
        {
            APIHelper apiHelper = new APIHelper();
            object json = new { result = apiHelper.deleteAsync("Productoes", id) };
            return json;
        }

        [WebMethod]
        public static object saveProducts(string FkIdCategoria, string Nombre, string Descripcion, string Imagen, string Precio)
        {
            APIHelper apiHelper = new APIHelper();
            object json =
                new
                {
                    result = apiHelper.saveAsync("Productoes",
                new Producto()
                {
                    PkIdProducto = 0,
                    FkIdCategoria = int.Parse(FkIdCategoria),
                    Nombre = Nombre,
                    Descripcion = Descripcion,
                    Imagen = Imagen,
                    Precio = decimal.Parse(Precio) 

                })
                };

            return json;
        }

        [WebMethod]
        public static object editProducts(string PkIdProducto, string FkIdCategoria, string Nombre, string Descripcion, string Imagen, string Precio)
        {
            APIHelper apiHelper = new APIHelper();
            object json =
                new
                {
                    result = apiHelper.editAsync("Productoes",
                  new Producto()
                  {
                      PkIdProducto = int.Parse(PkIdProducto),
                      FkIdCategoria = int.Parse(FkIdCategoria),
                      Nombre = Nombre,
                      Descripcion = Descripcion,
                      Imagen = Imagen,
                      Precio = decimal.Parse(Precio)
                  }
                  , PkIdProducto)
                };

            return json;
        }

    }
}