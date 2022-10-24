using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web_App_DonChamba.Models;
namespace Web_App_DonChamba
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          if (Session["AuthUser"] is  null)
            Response.Redirect("~/Login.aspx");
            
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["AuthUser"] = null;
            Auth.sucursal =null;
            Auth.user = null;
            Auth.Logged = false;
            Response.Redirect("~/Login.aspx");
        }
    }
}