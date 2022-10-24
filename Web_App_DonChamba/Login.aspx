<%@ Page Language="C#" AutoEventWireup="true" Async="true" CodeBehind="Login.aspx.cs" Inherits="Web_App_DonChamba.Login" %>
 
<!DOCTYPE html>

<html>
<head runat="server">
    <meta name="viewport" content = "width =device-width, initial-scale = 1.0, maximum-scale = 1.0, user-scalable = no"/>
    <title>Login - Don Chamba</title>
    <link href="Content/bootstrap.css" rel="stylesheet" type="text/css"  />
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin >
<link href="https://fonts.googleapis.com/css2?family=Raleway:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet" />
    <link href="Content/Site.css" rel="stylesheet" type="text/css"  />
    <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />
      <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="login-background pt-5 pb-5 ">
    <script> 

        function alert() {
            Swal.fire('Contraseña o usuario incorrectos',
                'Verifica tus credenciales',
                'warning');
        }

        

        function alert2() {
            Swal.fire('Campos vacios',
                'Verifica tus credenciales',
                'warning');
        }
    </script>
    <div class="container d-flex justify-content-center">
        <div class="bg-white rounded shadow p-5 align-self-center LoginPanel ">
            <div class="text-center">
                <img src="Assets/IMG/logodonchamba.jpg" /> 
            </div>
            <h2 class="text-center"> Inicio de Sesi&oacuten </h2>
            <p class="text-center text-muted"> Identif&iacutequese para poder continuar </p>
            <hr />
            <form runat="server" method="post" class="row text-center">
                <div class="col-12"> 
                    <div class="form-group mb-3"> 
                        <label for="txtUsername"> Introduce tu usuario: </label>
                        <asp:TextBox runat="server" class="form-control mw-100 p-2 m-2"
                        ID="txtUsername" MaxLength="18" 
                        Placeholder="Nombre de usuario" required="true"> </asp:TextBox> 
                    </div>
                </div>
                <div class="col-12"> 
                     <div class="form-group mb-3"> 
                        <label for="txtUsername"> Introduce tu contraseña: </label>
                        <asp:TextBox runat="server" class="form-control mw-100 p-2 m-2" 
                        ID="txtPassword" MaxLength="25" TextMode="Password"
                        Placeholder="************" required="true"> </asp:TextBox> 
                    </div>
                </div>
                 
                <div class="form-group mb-3">  
                    <asp:Button runat="server" ID="btnLogin" OnClick="btnLogin_Click" Text="Iniciar" CssClass="btn btn-primary"/>
                </div>
            </form>

        </div>
    </div>
    <script src="Scripts/bootstrap.js"></script>
    <script src="Scripts/jquery-3.4.1.js"></script>
    
</body>
</html>
