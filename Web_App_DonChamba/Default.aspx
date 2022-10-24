<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web_App_DonChamba._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">

        <div class="col-md-3 mb-3" > 
            <div class="bg-snow p-3 border shadow rounded text-center" style="min-height:100%;">
                <i class="fa-solid fa-building text-primary" style="font-size:48px;"></i>
                <h3 id="countCompanies"> </h3>
                <h6> Sucursales </h6>
            </div> 
        </div>
         <div class="col-md-3  mb-3"> 
            <div class="bg-snow p-3 border shadow rounded text-center" style="min-height:100%;">
                <i class="fa-solid fa-person text-primary" style="font-size:48px;"></i>
                 <h3 id="countUsers"> </h3>
                <h6> Vendedores </h6>
            </div> 
        </div>
         <div class="col-md-3  mb-3"> 
            <div class="bg-snow p-3 border shadow rounded text-center" style="min-height:100%;">
                <i class="fa-solid fa-boxes-stacked text-primary" style="font-size:48px;"></i>
                <h3 id="countProducts"> </h3>
                <h6> Productos </h6>
            </div> 
        </div>
         <div class="col-md-3  mb-3"> 
            <div class="bg-snow p-3 border shadow rounded text-center" style="min-height:100%;">
                <i class="fa-solid fa-truck text-primary" style="font-size:48px;"></i>
                 <h3 id="countOrders"> </h3>
                <h6> Pedidos </h6>
            </div> 
        </div>
        <br />
        <hr />

    </div>
    <script>
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "/Companies.aspx/getCompanies",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $('#countCompanies').append(response.d.data.length);
                    $.ajax({
                        type: "POST",
                        url: "/Users.aspx/getUsers",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            $('#countUsers').append(response.d.data.length);
                            $.ajax({
                                type: "POST",
                                url: "/Orders.aspx/getOrders",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (response) {
                                    $('#countOrders').append(response.d.data.length);
                                    $.ajax({
                                        type: "POST",
                                        url: "/Products.aspx/getProducts",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        success: function (response) {
                                            $('#countProducts').append(response.d.data.length);
                                        }
                                    });
                                }
                            });

                             
                        }
                    });

                     
                }
            });

             
        });
    </script>

</asp:Content>
