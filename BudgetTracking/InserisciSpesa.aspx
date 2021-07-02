<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InserisciSpesa.aspx.cs" Inherits="BudgetTracking.InserisciSpesa" MasterPageFile="~/Site1.Master" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="OrdersContentPlaceHolder" runat="server">

    <h1 class="login-form-main-message">Inserisci Spesa</h1>


    <div class="row">
        <form id="form1" class="main-login-form">
            <%--DataSourceID="ObjectDataSource1"--%>
            <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True"
                 AutoGenerateRows="False"
                DefaultMode="Insert" DataKeyNames="OrderID" BorderStyle="None" GridLines="None" ClientIDMode="Static">
                <Fields>
                    <asp:TemplateField>
                        <InsertItemTemplate>
                            <div class="col-xl-12 d-flex">
                                <div class="form-group">
                                    <label for="txtData" class="sr-only">Data</label>
                                    <div class="col-md-12 col-sm-12 d-inline-block">
                                        <asp:TextBox runat="server" ID="txtData" CssClass="datepicker-field form-control" Text='<%#  Bind("OrderDate") %>' HtmlEncode="false"  DataFormatString="{0:dd/mm/yyyy}" placeholder="Data"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <InsertItemTemplate>
                            <div class="col-xl-12 d-flex">
                                <div class="form-group">
                                    <label for="txtDescrizione" class="sr-only">Descrizione</label>
                                    <div class="col-md-12 col-sm-12 d-inline-block">
                                        <asp:TextBox runat="server" ID="txtName" CssClass="form-control" Text='<%#  Bind("OrderName") %>' placeholder="Descrizione"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <InsertItemTemplate>
                            <div class="col-xl-12 d-flex">
                                <div class="form-group">
                                    <label for="txtImporto" class="sr-only">Importo</label>
                                    <div class="col-md-12 col-sm-12 d-inline-block">
                                        <asp:TextBox runat="server" ID="txtImporto" CssClass="form-control numberInput" Text='<%#  Bind("OrderAmount") %>' placeholder="Importo"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <InsertItemTemplate>
                            <div class="col-xl-12 d-flex">
                                <div class="form-group">
                                    <asp:Button ID="BtnInsert" CssClass="btn btn-primary"
                                        CommandName="Insert"
                                        runat="server" Text="Inserisci" onclientclick="request()" />
                                </div>
                            </div>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <InsertRowStyle BorderStyle="None" />
                <PagerStyle BorderStyle="None" />
                <RowStyle BorderStyle="None" />
            </asp:DetailsView>

           <%-- <asp:ObjectDataSource runat="server" ID="OrdersDataSource"
                DataObjectTypeName="Order" DeleteMethod="DeleteOrder"
                InsertMethod="InsertOrder"
                OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetOrders" TypeName="OrderDB"
                ConflictDetection="CompareAllValues">
                <UpdateParameters>
                    <asp:Parameter Name="original_Order" Type="Object"></asp:Parameter>
                    <asp:Parameter Name="order" Type="Object"></asp:Parameter>
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="order" Type="Object"></asp:Parameter>
                </InsertParameters>
            </asp:ObjectDataSource>--%>
        </form>
    </div>
   
      <script src="https://code.jquery.com/jquery-1.12.4.js"></script>

        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

        <!-- Popper.JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
        <!-- Bootstrap JS -->
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/autonumeric/2.0.0/autoNumeric.min.js"></script>
    <script type="text/javascript">
        function request() {
            getRawNumerics();
            var params = getParams();
            //var v = $('#txtImporto').autoNumeric('get');
            //$('#txtImporto').autoNumeric('destroy');
            //$('#txtImporto').val(v);
            //console.log(v);
            console.log(params);
            console.log(JSON.stringify(params));
            __doPostBack("InsertSpesa", JSON.stringify(params))
        }

        function getParams() {
            return params =
            {
                  "OrderDate": $('#txtData').val()
                , "OrderName": $('#txtName').val()
                , "OrderAmount": $('#txtImporto').val()
            };
        }
    </script>


</asp:Content>
