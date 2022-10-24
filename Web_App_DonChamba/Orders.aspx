<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="Web_App_DonChamba.Orders" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


   

    <!-- Modal -->
    <div class="modal fade" id="Modal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalLabel"> </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <label for="txtcompanypiker">Estado: </label>
                        <select class="selectpicker  show-tick form-control mw-100 border" id="txtcompanypiker"
                            data-size="5" title="Seleccione la sucursal..." data-live-search="true" >
                            <option value="0"> En proceso </option>
                            <option value="1"> Procesada/Entregada </option>
                            <option value="2"> Comision pagada </option> 
                            <option value="3"> Rechazada </option> 
                        </select>
                        <small>Selecciona el estado de la orden</small>
                    </div>
                </div> 
                 
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" id="btnsave">Guardar</button>
                </div>
            </div>
        </div>
    </div>

     <!-- Modal -->
    <div class="modal fade" id="ModalOrderDetails" tabindex="-1" aria-labelledby="ModalOrderDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalOrderDetailsModalLabel"> </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <div id="orderdetails">

                    </div>
                </div> 
                 
                <div class="modal-footer"> 
                </div>
            </div>
        </div>
    </div>


    <div class=" table-responsive">
        <table class="bg-snow border shadow mt-3 overflow-auto display" id="table_id">
            <thead>
                <tr>
                    <th>Acciones</th>
                    <th>Order #</th>
                    <th>Estado</th>
                    <th>Vendedor</th> 
                    <th>Total</th>
                    <th>Comisi&oacuten (2%) </th>
                </tr>
            </thead>
            <tbody>
                

            </tbody>
        </table>
    </div>


    <script>

        var Users;

        function loadUsers() {
            $.ajax({
                type: "POST",
                url: "/Users.aspx/getUsers",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    Users = response.d.data;
                    loadproducts();
                }
            }); 
        }

        var products;

        function loadproducts() {
            $.ajax({
                type: "POST",
                url: "/Products.aspx/getProducts",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    products = response.d.data;
                    console.log(products);
                }
            });
        }

         
        var table;
        $(document).ready(function () { 
            loadUsers();  
            table = $('#table_id').DataTable({
                responsive: true,
                select: true,
                ajax: {
                    method: "POST",
                    url: '/Orders.aspx/getOrders',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    dataSrc: 'd.data' 
                },
                columns: [
                    {
                        data: 'PkIdOrden', render: function (data, type, row, meta) {
                            return "<button type='button' class='btn btn-primary m-1' onclick='Details(" + JSON.stringify(row) + ")'> <i class='fa-solid fa-circle-info'></i> </button>" +
                                "<button type='button' class='btn btn-primary m-1' onclick='Edit(" + JSON.stringify(row) + ")'> <i class='fa-solid fa-pen-to-square'></i> </button>"
                                 ;
                        }
                    },
                    { data: 'PkIdOrden' },
                    {
                        data: 'Estado', render: function (data, type, row, meta) {
                            if (row.Estado == 0) { return 'En proceso' }
                            if (row.Estado == 1) { return 'Procesada/Entregada' }
                            if (row.Estado == 2) { return 'Comision pagada' }
                            if (row.Estado == 3) { return 'Rechazada' } 
                        }
                    },
                    {
                        data: 'FkIdUsuario', render: function (data, type, row, meta) {
                            var obj = row;
                            var UserName;
                            $.each(Users, function (i, v) {
                                if (v.PkIdUsuario == obj.FkIdUsuario) {
                                    UserName = v.Nombres + " " + v.Apellidos + " ("+ v.Usuario1 +")";
                                    return;
                                }
                            });  
                            return " " + UserName +" ";
                        }
                    }, 
                    { data: 'Total', render: function (data, type, row, meta) { return '$' + parseFloat(row.Total).toFixed(2);   } },
                    {
                        render: function (data, type, row, meta) { return '$' + parseFloat(row.Total * 0.02).toFixed(2) }
                    }
                ]
                ,
                language: {
                    "url": "Scripts/SpanishDatatable.json"
                }
            }); 

        });
         
        function Edit(model) {
            $('.selectpicker').val(model.Estado);
            $('.selectpicker').selectpicker('refresh');
            $('#ModalLabel').empty();
            $('#ModalLabel').append('Editar estado de orden');
            $('#Modal').modal('show');
            $('#btnsave').attr('onclick', 'SaveEdit(' + JSON.stringify(model) + ')');

        }

        function Details(model) {
            $('#ModalOrderDetailsModalLabel').empty();
            $('#ModalOrderDetailsModalLabel').append('Detalles de Orden');
            $('#ModalOrderDetails').modal('show');
            var obj = {};
            obj.PkIdOrden = model.PkIdOrden;
            $.ajax({
                type: "POST",
                url: "/Orders.aspx/getOrderDetails",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {  
                    orderdetails = msg.d['result'];
                    console.log(orderdetails);
                    $('#orderdetails').empty();
                     
                    for (k = 0; k < orderdetails.length; k++) {
                        var productsname, productdescription;
                        $.each(products, function (i, v) {
                            if (v.PkIdProducto == orderdetails[k].FkIdProducto) {
                                productsname = v.Nombre; productdescription = v.Descripcion  ;
                                return;
                            }
                        });
                        $('#orderdetails').append('Producto: ' + productsname + '<br>');
                        $('#orderdetails').append('Descripci&oacuten: ' + productdescription + '<br>');
                        $('#orderdetails').append('Cantidad: ' + orderdetails[k].Cantidad + '<br>');
                        $('#orderdetails').append('Subtotal: ' + '$' + parseFloat(orderdetails[k].Subtotal * 0.02).toFixed(2)   + '<br>');
                        $('#orderdetails').append('<hr>');
                    }
                }
            });
        }
 
        function SaveEdit(model) {
            if ($('.selectpicker').val().trim().length > 0  ) {
                var obj = {}; 
                obj.PkIdOrden = model.PkIdOrden;
                obj.FkIdUsuario = model.FkIdUsuario;
                obj.Estado = $('.selectpicker').val().trim();
                obj.Comentario = model.Comentario;
                obj.Total = model.Total;
                console.log(obj);
                $.ajax({
                    type: "POST",
                    url: "/Orders.aspx/editOrders",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        console.log(msg);
                        if (msg.d['result'] == true) { 
                            table.ajax.reload(); 
                            $('#Modal').modal('hide');
                        }
                        else {
                            Swal.fire(
                                'No se pudo modificar este registro',
                                '',
                                'warning'
                            );
                        }
                    }
                });
            }  
        }

         
    </script>
</asp:Content>
