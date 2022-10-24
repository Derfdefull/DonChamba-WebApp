<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Companies.aspx.cs" Inherits="Web_App_DonChamba.Companies" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Button trigger modal -->
    <button type="button" class="btn btn-outline-primary mb-3"   onclick="New()">
        Nueva sucursal
    </button>

    <!-- Modal -->
    <div class="modal fade" id="Modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Crear nueva sucursal</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">
                    <div class="form-group">
                        <label for="txtCategory">Nombre*: </label>
                        <input class="form-control mw-100" name="txtCompany" id="txtCompany" type="text"   />
                        <small>Introduce el nombre de sucursal</small>
                    </div>
              

                
                    <div class="form-group">
                        <label for="txtCategory">Tel&eacutefono*: </label>
                        <input class="form-control mw-100" name="txtCPhone" id="txtCPhone" type="text"   />
                        <small>Introduce el tel&eacutefono</small>
                    </div>
                 
                 

                    <div class="form-group">
                        <label for="txtCategory">Direcci&oacuten*: </label>
                        <textarea class="form-control mw-100" name="txtCAddress" id="txtCAddress" type="text"   ></textarea>
                        <small>Introduce la direcci&oacuten</small>
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
        <table class="bg-snow border shadow mt-3 overflow-auto display" id="table_id"  >
            <thead>
                <tr>
                    <th>Acciones</th>
                    <th>C&oacutedigo</th>
                    <th>Nombre</th>
                    <th>Direcci&oacuten</th>
                    <th>Tel&eacutefono</th>
                </tr>
            </thead>
            <tbody> 
            </tbody>
        </table>
    </div>
   

      <script> 
          var table;
          $(document).ready(function () {
              table = $('#table_id').DataTable({
                  responsive: true,
                  select: true,
                  ajax: {
                      method: "POST",
                      url: '/Companies.aspx/getCompanies',
                      contentType: 'application/json; charset=utf-8',
                      dataType: 'json',
                      dataSrc: 'd.data'
                  },
                  columns: [
                      {
                          data: 'PkIdSucursal', render: function (data, type, row, meta) {
                              return "<button type='button' class='btn btn-primary m-1' onclick='Edit(" + JSON.stringify(row) + ")'> <i class='fa-solid fa-pen-to-square'></i> </button>" +
                                  "<button type='button' class='btn btn-danger m-1' onclick='Delete(" + JSON.stringify(row) + ")'> <i class='fa-solid fa-trash'></i> </button>";
                          }
                      },
                      { data: 'PkIdSucursal' },
                      { data: 'Nombre' },
                      { data: 'Direccion' },
                      { data: 'Telefono' }
                  ]
                  ,
                  language: {
                      "url": "Scripts/SpanishDatatable.json"
                  }
              });




          });

          function New() { 
              $('#txtCompany').val('');
              $('#txtCAddress').val('');
              $('#txtCPhone').val('');
              $('#ModalLabel').empty();
              $('#ModalLabel').append('Nueva sucursal');
              $('#Modal').modal('show');
              $('#btnsave').attr('onclick', 'SaveNew()');

          }

          function Edit(model) { 
              $('#txtCompany').val(model.Nombre);
              $('#txtCAddress').val(model.Direccion);
              $('#txtCPhone').val(model.Telefono);
              $('#ModalLabel').empty();
              $('#ModalLabel').append('Editar sucursal');
              $('#Modal').modal('show');
              $('#btnsave').attr('onclick', 'SaveEdit(' + model.PkIdSucursal + ')');

          }

          function SaveNew() {
              if ($('#txtCompany').val().trim().length > 0 &&
                  $('#txtCAddress').val().trim().length > 0 &&
                  $('#txtCPhone').val().trim().length > 0  ) {
                  var obj = {};
                  obj.Nombre = $('#txtCompany').val().trim();
                  obj.Direccion = $('#txtCAddress').val().trim();
                  obj.Telefono = $('#txtCPhone').val().trim(); 
                  $.ajax({
                      type: "POST",
                      url: "/Companies.aspx/saveCompanies",
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
              if ($('#txtCompany').val().trim().length > 0 &&
                  $('#txtCAddress').val().trim().length > 0 &&
                  $('#txtCPhone').val().trim().length > 0 ) {
                  var obj = {};
                  obj.PkIdSucursal = id;
                  obj.Nombre = $('#txtCompany').val().trim();
                  obj.Direccion = $('#txtCAddress').val().trim();
                  obj.Telefono = $('#txtCPhone').val().trim();
                  console.log(obj);
                  $.ajax({
                      type: "POST",
                      url: "/Companies.aspx/editCompanies",
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
                      'hay campos vacios',
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
                      obj.id = model.PkIdSucursal;
                      $.ajax({
                          type: "POST",
                          url: "/Companies.aspx/deleteCompanies",
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
