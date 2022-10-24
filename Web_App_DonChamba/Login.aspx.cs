using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Web_App_DonChamba.Services;
using Web_App_DonChamba.Models;
using System.Threading.Tasks;

namespace Web_App_DonChamba
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack && Session["AuthUser"] != null) 
                Response.Redirect("~/Default.aspx");
            

            if (!IsPostBack) 
                VerifyLogin();
            else 
                ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert()", true);
           
        }

        protected async void btnLogin_Click(object sender, EventArgs e)
        {
            if(txtPassword.Text.Trim() != "" && txtUsername.Text.Trim() != "")
            {
                var Login = new Auth()
                { Usuario = txtUsername.Text, Contrasena = txtPassword.Text };

                var APIHelper = new APIHelper();
                await APIHelper.AuthUserAsync(Login);
               
                VerifyLogin();
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "aa", "alert2()", true);
            }
        }

        private void VerifyLogin()
        {
            if (Auth.Logged == true)
            { 
                Session["AuthUser"] = new Auth();
                Response.Redirect("~/Default.aspx");
            }
            
        }
    }
}