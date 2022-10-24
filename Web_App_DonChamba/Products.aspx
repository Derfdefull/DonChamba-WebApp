<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="Web_App_DonChamba.Products" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Button trigger modal -->
    <button type="button" class="btn btn-outline-primary mb-3" onclick="New()">
        Nuevo producto
    </button>

    <!-- Modal -->
    <div class="modal fade" id="Modal" tabindex="-1"  >
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalLabel">Crear nuevo producto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                 <div class="modal-body">
                    <div class="form-group">
                        <label for="txtUName">Categoria*: </label>
                        <select class="selectpicker show-tick form-control mw-100 border" id="txtcompanypiker"
                            data-size="5" title="Seleccione la sucursal..." data-live-search="true" > 
                        </select>
                        <small>Selecciona la categoria del producto</small>
                    </div>
             

                
                    <div class="form-group">
                        <label for="txtUName">Imagen*: </label>
                        <br />
                        <div class="text-center">
                        <img id="blah" src="#" alt="" class="border shadow rounded"  width="50%" height="auto"/>
                            <hr />
                        </div>
                        <input class="form-control mw-100"  id="PIMG" type="file" accept=".png, .jpg, .jpeg"  />
                        <small>Sube la imagen del producto</small>
                        
                         
                    </div>
                

                 
                    <div class="form-group">
                        <label for="txtUName">Nombre*: </label>
                        <input class="form-control mw-100" name="txtPName" id="txtPName" type="text"  />
                        <small>Introduce el nombre de producto</small>
                    </div>
                

              
                    <div class="form-group">
                        <label for="txtULastname">Detalles*: </label>
                        <input class="form-control mw-100" name="txtPDetails" id="txtPDetails" type="text"  />
                        <small>Introduce detalles del producto</small>
                     </div>
               

                
                    <div class="form-group">
                        <label for="txtUName">Precio*: </label>
                        <input class="form-control mw-100" name="txtPPrice" id="txtPPrice" type="text" />
                        <small>Introduce precio del producto</small>
                    
                </div>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="button" class="btn btn-primary" id="btnsave">Guardar</button>
                </div>
            </div>
        </div>
    </div>

    <div class=" table-responsive text-center">
        <table class="bg-snow border shadow mt-3 overflow-auto display" id="table_id"  >
            <thead>
                <tr>
                    <th>Acciones</th>
                    <th>Categoria</th>
                    <th>Imagen</th>
                    <th>Nombre</th>
                    <th>Descripci&oacuten</th>
                    <th>Precio</th>
                </tr>
            </thead>
            <tbody>
                  
            </tbody>
        </table>
    </div>
   

   
    <script>
        var fileuploader;
        var imgmodifed = false;
        function readURL() { 
            if (fileuploader.files && fileuploader.files[0]) {
                var reader = new FileReader();
                var sender = {};
                sender.imgdata = 0;
                reader.onload = function (e) {
                    $('#blah').attr('src', e.target.result);
                    sender.imgdata = e.target.result;  
                } 
                reader.readAsDataURL(fileuploader.files[0]);
            }
        }

        $("#PIMG").change(function () {
            fileuploader = this;
            readURL();  
        });

        function loadURLToInputFiled(url) {
            getImgURL(url, (imgBlob) => { 
                let fileName = 'productimg.jpg'
                let file = new File([imgBlob], fileName, { type: "image/jpeg", lastModified: new Date().getTime() }, 'utf-8');
                let container = new DataTransfer();
                container.items.add(file);
                document.querySelector('#PIMG').files = container.files;
                fileuploader = $("#PIMG")[0];
                readURL();
            })
        }

        function getImgURL(url, callback) {
            var xhr = new XMLHttpRequest();
            xhr.onload = function () {
                callback(xhr.response);
            };
            xhr.open('GET', url);
            xhr.responseType = 'blob';
            xhr.send();
        }

        var categories;

        function loadCategories() {
            $.ajax({
                type: "POST",
                url: "/Categories.aspx/getCategories",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    categories = response.d.data;
                    for (var i = 0; i < response.d.data.length; i++) {
                        $('#txtcompanypiker').append("<option value='" + response.d.data[i]['PkIdCategoria'] + "'> " + response.d.data[i]['Nombre'] + " </option>");
                    }
                    $('#txtcompanypiker').selectpicker();
                    $('.selectpicker').selectpicker('refresh');
                }
            });


        }

        var table;
        $(document).ready(function () {
            loadCategories();

            table = $('#table_id').DataTable({
                responsive: true,
                select: true,
                ajax: {
                    method: "POST",
                    url: '/Products.aspx/getProducts',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    dataSrc: 'd.data'
                },
                columns: [
                    {
                        data: 'PkIdProducto', render: function (data, type, row, meta) {
                            return "<button type='button' class='btn btn-primary m-1' onclick='Edit(" + JSON.stringify(row) + ")'> <i class='fa-solid fa-pen-to-square'></i> </button>" +
                                "<button type='button' class='btn btn-danger m-1' onclick='Delete(" + JSON.stringify(row) + ")'> <i class='fa-solid fa-trash'></i> </button>";
                        }
                    },
                    {
                        data: 'FkIdCategoria', render: function (data, type, row, meta) {
                            var obj = row;
                            var companyName; 
                            $.each(categories, function (i, v) { 
                                if (v.PkIdCategoria == obj.FkIdCategoria) {
                                    companyName = v.Nombre;
                                    return;
                                }
                            });  
                            return "<p>" + companyName + "</p>";
                        }
                    },
                    {
                        data: 'Imagen', render: function (data, type, row, meta) {
                            var obj = row;

                            return "<img src='" + obj.Imagen + "' width='150' height='auto'  />";
                        }
                    },
                    { data: 'Nombre' },
                    { data: 'Descripcion' },
                    {
                        data: 'Precio', render: function (data, type, row, meta) {
                            return '$' + parseFloat(row.Precio).toFixed(2);
                        }
                    }
                ]
                ,
                language: {
                    "url": "Scripts/SpanishDatatable.json"
                }
            });




        });

        function New() {
            $('#txtPName').val('');
            $('#txtPDetails').val('');
            $('#txtPPrice').val(''); 
            $('#ModalLabel').empty();
            $('#ModalLabel').append('Nuevo producto');
            $('#Modal').modal('show');
            $('#btnsave').attr('onclick', 'SaveNew()');

        }

        function Edit(model) {
            $('.selectpicker').val(model.FkIdCategoria);
            $('.selectpicker').selectpicker('refresh');
            $('#txtPName').val(model.Nombre);
            $('#txtPDetails').val(model.Descripcion);
            $('#txtPPrice').val(model.Precio); 
            loadURLToInputFiled("https://" + window.location.host + model.Imagen);
            $('#ModalLabel').empty();
            $('#ModalLabel').append('Editar Producto');
            $('#Modal').modal('show');
            $('#btnsave').attr('onclick', 'SaveEdit(' + model.PkIdProducto + ', "' + model.Imagen +'")'); 
        }

        function SaveNew() {
            if ($('.selectpicker').val().trim().length > 0 && $('#txtPName').val().trim().length > 0 &&
                $('#txtPDetails').val().trim().length > 0 && $('#txtPPrice').val().trim().length > 0) {

                var obj = {};
                obj.FkIdCategoria = $('.selectpicker').val().trim();
                obj.Nombre = $('#txtPName').val().trim();
                obj.Descripcion = $('#txtPDetails').val().trim();
                obj.Precio = $('#txtPPrice').val().trim();

                if (fileuploader.files && fileuploader.files[0]) {
                    var reader = new FileReader();
                    var sender = {};
                    sender.imgdata = 0;
                    reader.onload = function (e) {
                        $('#blah').attr('src', e.target.result);
                        sender.imgdata = e.target.result;

                        $.ajax({
                            type: "POST",
                            url: "/Products.aspx/saveImg",
                            data: JSON.stringify(sender),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                obj.Imagen = response.d.path;
                                $.ajax({
                                    type: "POST",
                                    url: "/Products.aspx/saveProducts",
                                    data: JSON.stringify(obj),
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (msg) {
                                        console.log(msg);
                                        if (msg.d['result'] == true) {
                                            Swal.fire({
                                                position: 'top-end',
                                                icon: 'success',
                                                title: 'Se guardo correctamente',
                                                showConfirmButton: false,
                                                timer: 1000
                                            });
                                            table.ajax.reload();
                                            $('#Modal').modal('hide');
                                        }
                                        else {
                                            Swal.fire(
                                                'Alerta',
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
                            },
                            error: function (response) {
                                console.log(response);
                            }
                        });
                    }
                    reader.readAsDataURL(fileuploader.files[0]);
                }
            } else {
                Swal.fire(
                    'Hay campos vacios',
                    '',
                    'warning'
                );
            }
        }

        function SaveEdit(id, img) {
            if ($('.selectpicker').val().trim().length > 0 && $('#txtPName').val().trim().length > 0 &&
                $('#txtPDetails').val().trim().length > 0 && $('#txtPPrice').val().trim().length > 0) {
                  
                var obj = {};
                obj.PkIdProducto = id;
                obj.FkIdCategoria = $('.selectpicker').val().trim();
                obj.Nombre = $('#txtPName').val().trim();
                obj.Descripcion = $('#txtPDetails').val().trim();
                obj.Precio = $('#txtPPrice').val().trim();
                 
                if (fileuploader.files && fileuploader.files[0]) {
                    var reader = new FileReader();
                    var sender = {};
                    sender.imgdata = 0;
                    reader.onload = function (e) {
                        $('#blah').attr('src', e.target.result);
                        sender.imgdata = e.target.result;
                        console.log(sender);
                        $.ajax({
                            type: "POST",
                            url: "/Products.aspx/saveImg",
                            data: JSON.stringify(sender),
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (response) {
                                console.log(response);
                                obj.Imagen = response.d.path;
                                $.ajax({
                                    type: "POST",
                                    url: "/Products.aspx/editProducts",
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
                                                'Alerta',
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
                            },
                            error: function (response) {
                                console.log(response);
                            }
                        });
                    }
                    reader.readAsDataURL(fileuploader.files[0]);
                }
            } else {
                Swal.fire(
                    'Hay campos vacios',
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
                    obj.id = model.PkIdProducto;
                    $.ajax({
                        type: "POST",
                        url: "/Products.aspx/deleteProducts",
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
