<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="Web_App_DonChamba.Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <!-- Button trigger modal -->
    <button type="button" class="btn btn-outline-primary mb-3" onclick="New()">
        Nuevo vendedor
    </button>

    <!-- Modal -->
    <div class="modal fade" id="Modal" tabindex="-1" aria-labelledby="ModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalLabel">Crear nuevo vendedor</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <label for="txtUName">Sucursal*: </label>
                        <select class="selectpicker  show-tick form-control mw-100 border" id="txtcompanypiker"
                            data-size="5" title="Seleccione la sucursal..." data-live-search="true">
                        </select>
                        <small>Selecciona la sucursal del vendedor </small>
                    </div>
                 

                
                    <div class="form-group">
                        <label for="txtUName">Nombre*: </label>
                        <input class="form-control mw-100" name="txtUName" id="txtUName" type="text"   />
                        <small>Introduce nombre del vendedor</small>
                    </div>
                 
               
                    <div class="form-group">
                        <label for="txtULastname">Apellido*: </label>
                        <input class="form-control mw-100" name="txtULastname" id="txtULastname" type="text"   />
                        <small>Introduce apellido del vendedor</small>
                    </div>
               
                 
                    <div class="form-group">
                        <label for="txtUPhone">Tel&eacutefono*: </label>
                        <input class="form-control mw-100" name="txtUPhone" id="txtUPhone" type="text"   />
                        <small>Introduce tel&eacutefon del vendedor</small>
                    </div>
               

                

                    <div class="form-group">
                        <label for="txtUCPhone">Celular*: </label>
                        <input class="form-control mw-100" name="txtUCPhone" id="txtUCPhone" type="text" />
                        <small>Introduce celular del vendedor</small>
                    </div>
               
                    <div class="form-group">
                        <label for="txtUName">Nombre de usuario*: </label>
                        <input class="form-control mw-100" name="txtUserName" id="txtUserName" type="text"   />
                        <small>Introduce nombre de usuario del vendedor</small>
                    </div>
                
                 
                    <div class="form-group">
                        <label for="txtULastname">Contraseña*: </label>
                        <input class="form-control mw-100" name="txtUserpass" id="txtUserpass" type="password"  />
                        <small>Introduce contraseña de usuario del vendedor</small>
                     </div>
                 </div>
                 
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" id="btnsave">Guardar</button>
                </div>
            </div>
        </div>
    </div>

    <div class=" table-responsive">
        <table class="bg-snow border shadow mt-3 overflow-auto display" id="table_id">
            <thead>
                <tr>
                    <th>Acciones</th>
                    <th>Sucursal</th>
                    <th>Usuario</th>
                    <th>Nombre</th>
                    <th>Celular</th>
                    <th>Tel&eacutefono</th>
                </tr>
            </thead>
            <tbody>
                

            </tbody>
        </table>
    </div>


    <script>

        var companies;

        function loadCompanies() {
            $.ajax({
                type: "POST",
                url: "/Companies.aspx/getCompanies",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    companies = response.d.data;
                    for (var i = 0; i < response.d.data.length; i++) {
                        $('#txtcompanypiker').append("<option value='" + response.d.data[i]['PkIdSucursal'] + "'> " + response.d.data[i]['Nombre'] + " </option>");
                    } 
                    $('#txtcompanypiker').selectpicker();
                    $('.selectpicker').selectpicker('refresh');
                }
            });


        }

        var table;
        $(document).ready(function () { 
            loadCompanies();

            table = $('#table_id').DataTable({
                responsive: true,
                select: true,
                ajax: {
                    method: "POST",
                    url: '/Users.aspx/getUsers',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    dataSrc: 'd.data' 
                },
                columns: [
                    {
                        data: 'PkIdUsuario', render: function (data, type, row, meta) {
                            return "<button type='button' class='btn btn-primary m-1' onclick='Edit(" + JSON.stringify(row) + ")'> <i class='fa-solid fa-pen-to-square'></i> </button>" +
                                "<button type='button' class='btn btn-danger m-1' onclick='Delete(" + JSON.stringify(row) + ")'> <i class='fa-solid fa-trash'></i> </button>";
                        }
                    }, 
                    {
                        data: 'FkIdSucursal', render: function (data, type, row, meta) { 
                            var obj = row;
                            var companyName;
                            $.each(companies, function (i, v) { 
                                if (v.PkIdSucursal == obj.FkIdSucursal) {
                                    companyName = v.Nombre;
                                    return;
                                }
                            }); 
                            console.log(companyName);
                            return "<p>" + companyName +"</p>";
                        }
                    },
                    { data: 'Usuario1' },
                    { data: 'Nombres' },
                    { data: 'Celular' },
                    { data: 'Telefono' }
                ]
                ,
                language: {
                    "url": "Scripts/SpanishDatatable.json"
                }
            });




        });

        function New() {
            $('#txtUName').val('');
            $('#txtULastname').val('');
            $('#txtUPhone').val('');
            $('#txtUCPhone').val('');
            $('#txtUPhone').val('');
            $('#txtUserName').val('');
            $('#txtUserpass').val('');
            $('#ModalLabel').empty();
            $('#ModalLabel').append('Nuevo vendedor');
            $('#Modal').modal('show');
            $('#btnsave').attr('onclick', 'SaveNew()');

        }

        function Edit(model) {
            $('.selectpicker').val(model.FkIdSucursal); 
            $('.selectpicker').selectpicker('refresh'); 
            $('#txtUName').val(model.Nombres);
            $('#txtULastname').val(model.Apellidos);
            $('#txtUPhone').val(model.Telefono);
            $('#txtUCPhone').val(model.Celular); 
            $('#txtUserName').val(model.Usuario1);
            $('#txtUserpass').val(model.Contrasena);
            $('#ModalLabel').empty();
            $('#ModalLabel').append('Editar vendedor');
            $('#Modal').modal('show');
            $('#btnsave').attr('onclick', 'SaveEdit(' + model.PkIdUsuario + ')');

        }

        function SaveNew() {
            if ($('.selectpicker').val().trim().length > 0 && $('#txtUserpass').val().trim().length > 0 &&
                $('#txtUserName').val().trim().length > 0 &&
                $('#txtUName').val().trim().length > 0 && $('#txtULastname').val().trim().length > 0) {
                var obj = {};
                obj.FkIdSucursal = $('.selectpicker').val().trim();
                obj.Nombres = $('#txtUName').val().trim();
                obj.Apellidos = $('#txtULastname').val().trim();
                obj.Celular = $('#txtUPhone').val().trim();
                obj.Telefono = $('#txtUCPhone').val().trim();
                obj.Usuario = $('#txtUserName').val().trim();
                obj.Contrasena = $('#txtUserpass').val().trim();
                console.log(obj);
                $.ajax({
                    type: "POST",
                    url: "/Users.aspx/saveUsers",
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
                                'Nombre de usuario ya esta ocupado',
                                'No se puede guardar este registro',
                                'warning'
                            );
                        }
                    },
                    error: function (msg) {
                        Swal.fire(
                            'No se puede guardar este registro',
                            '',
                            'warning'
                        );
                    }
                });
            } else {
                Swal.fire(
                    'Campos Vacios',
                    '',
                    'warning'
                );
            }
        }

        function SaveEdit(id) {
            if ($('.selectpicker').val().trim().length > 0 && $('#txtUserpass').val().trim().length > 0 &&
                $('#txtUserName').val().trim().length > 0 &&
                $('#txtUName').val().trim().length > 0 && $('#txtULastname').val().trim().length > 0) {
                var obj = {}; 
                obj.PkIdUsuario = id;
                obj.FkIdSucursal = $('.selectpicker').val().trim();
                obj.Nombres = $('#txtUName').val().trim();
                obj.Apellidos = $('#txtULastname').val().trim();
                obj.Celular = $('#txtUPhone').val().trim();
                obj.Telefono = $('#txtUCPhone').val().trim();
                obj.Usuario = $('#txtUserName').val().trim();
                obj.Contrasena = $('#txtUserpass').val().trim();
                console.log(obj);
                $.ajax({
                    type: "POST",
                    url: "/Users.aspx/editUsers",
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
            } else {
                Swal.fire(
                    'Campos Vacios',
                    '',
                    'warning'
                );
            }
        }

        function Delete(model) {
            Swal.fire({
                title: '¿Estás seguro de eliminar este registro?',
                text: "Este proceso no es reversible",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Si, Eliminar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    var obj = {};
                    obj.id = model.PkIdUsuario;
                    $.ajax({
                        type: "POST",
                        url: "/Users.aspx/deleteUsers",
                        data: JSON.stringify(obj),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            console.log(msg);
                            if (msg.d['result'] == true) { 
                                table.ajax.reload();
                            } else {
                                Swal.fire(
                                    'No se puede eliminar este registro!',
                                    'La sucursal contiene vendedores...',
                                    'warning'
                                );
                            }
                        },
                        error: function (msg) {
                            alert(msg.d);
                        }
                    });


                }
            })
        }
    </script>

</asp:Content>
