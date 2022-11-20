<%@ Page Title="Categorias" Async="true" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="Web_App_DonChamba.Services.Categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     
    <!-- Button trigger modal -->
    <button type="button" class="btn btn-outline-primary mb-3" onclick="New()">
        Nueva categoria
    </button>

    <!-- Modal -->
    <div class="modal fade" id="CategoryModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <label class="modal-title" style="font-size: large" id="CategoryModalLabel"></label>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body"> 
                        <div class="col-md-12 position-relative">
                            <label for="txtCategory">Nombre: </label>
                            <input class="form-control mw-100" name="txtCategory" id="txtCategory" type="text"  />
                            <small> Introduce el nombre de categoria </small> 
                        </div>  
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" id="btnsave">Guardar</button>
                </div>
            </div>
        </div>
    </div>

    <table class="table table-striped dt-responsive nowrap border shadow mt-3 display" id="table_id"   >
        <thead>
            <tr>
                <th>Acciones</th> 
                <th>Nombre</th>
            </tr>
        </thead>
        <tbody> </tbody>
    </table>

    <script>
         
        var table;
        $(document).ready(function () { 
           table = $('#table_id').DataTable({
                responsive: true,
                select: true,
                ajax: {
                    method: "POST",
                    url: '/Categories.aspx/getCategories',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json', 
                    dataSrc: 'd.data'
                },
                columns: [
                    {
                        data: 'PkIdCategoria', render: function (data, type, row, meta) { 
                            return "<button type='button' class='btn btn-primary m-1' onclick='Edit("+JSON.stringify(row) +")'> <i class='fa-solid fa-pen-to-square'></i> </button>" +
                                "<button type='button' class='btn btn-danger m-1' onclick='Delete(" + JSON.stringify(row) +")'> <i class='fa-solid fa-trash'></i> </button>";
                        }
                    }, 
                    { data: 'Nombre' }
                    ]
                ,
                language: {
                    "url": "Scripts/SpanishDatatable.json"
                }
            });


             

        });

        function New() { 
            $('#txtCategory').val('');
            $('#CategoryModalLabel').empty();
            $('#CategoryModalLabel').append('Nueva categoria');
            $('#CategoryModal').modal('show');
            $('#btnsave').attr('onclick', 'SaveNew()');

        }

        function Edit(Category) {
            console.log(Category);
            $('#txtCategory').val(Category.Nombre);
            $('#CategoryModalLabel').empty();
            $('#CategoryModalLabel').append('Editar categoria');
            $('#CategoryModal').modal('show');
            $('#btnsave').attr('onclick', 'SaveEdit('+Category.PkIdCategoria+')');

        }

        function SaveNew() {  
            if ($('#txtCategory').val().trim().length > 0) {
                var obj = {};
                obj.Nombre = $('#txtCategory').val().trim();
                console.log(obj);
                $.ajax({
                    type: "POST",
                    url: "/Categories.aspx/saveCategories",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        console.log(msg);
                        if (msg.d['result'] == true) { 
                            table.ajax.reload();
                            $('#CategoryModal').modal('hide');
                        }
                        else {
                            Swal.fire(
                                'No se puede guardar este registro',
                                '',
                                'warning'
                            );
                        }
                    }
                });
            } else {
                Swal.fire(
                    'hay campos vacios',
                    '',
                    'warning'
                );
            }
                 
           
        }

        function SaveEdit(id) {
            if ($('#txtCategory').val().trim().length > 0) {
                var obj = {};
                obj.PkIdCategoria = id
                obj.Nombre = $('#txtCategory').val().trim();
                console.log(obj);
                $.ajax({
                    type: "POST",
                    url: "/Categories.aspx/editCategories",
                    data: JSON.stringify(obj),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        console.log(msg);
                        if (msg.d['result'] == true) {
                            Swal.fire({
                                position: 'top-end',
                                icon: 'success',
                                title: 'Se modifico correctamente',
                                showConfirmButton: false,
                                timer: 1000
                            });
                            table.ajax.reload();
                            $('#CategoryModal').modal('hide');
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
                    'Hay campos vacios',
                    '',
                    'warning'
                );
            }
        }

        function Delete(Category) {
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
                    obj.id = Category.PkIdCategoria;
                    $.ajax({
                        type: "POST",
                        url: "/Categories.aspx/deleteCategories",
                        data: JSON.stringify(obj),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            console.log(msg);
                            if (msg.d['result'] == true) { 
                                table.ajax.reload();
                            } else {
                                Swal.fire(
                                    'No se puede eliminar este registro',
                                    'La categoria contiene dependencias...',
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
