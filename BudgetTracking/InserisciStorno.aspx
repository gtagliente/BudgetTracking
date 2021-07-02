<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InserisciStorno.aspx.cs" Inherits="BudgetTracking.InserisciStorno" MasterPageFile="~/Site1.Master" EnableEventValidation="false" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="OrdersContentPlaceHolder" runat="server">

    <h1 class="login-form-main-message">Inserisci Storno</h1>


    <div class="row">
        <form id="form1" class="main-login-form">

            <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True"
                DataSourceID="ObjectDataSource1" AutoGenerateRows="False"
                DefaultMode="Insert" DataKeyNames="OrderID" BorderStyle="None" GridLines="None">
                <Fields>
                    <asp:TemplateField>
                        <InsertItemTemplate>
                            <div class="col-xl-12 d-flex">
                                <div class="form-group">
                                    <label for="txtData" class="sr-only">Data</label>
                                    <div class="col-md-12 col-sm-12 d-inline-block">
                                        <asp:TextBox runat="server" ID="txtData" CssClass="datepicker-field form-control" Text='<%#  Bind("Data") %>' DataFormatString="{0:dd/MM/yyyy}" placeholder="Data"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <InsertItemTemplate>
                            <%--<div class="col-xl-12 d-flex">
                                <div class="form-group">
                                    <label for="txtDescrizione" class="sr-only">Descrizione</label>
                                    <div class="col-md-12 col-sm-12 d-inline-block">
                                        <asp:TextBox runat="server" ID="txtName" CssClass="form-control" Text='<%#  Bind("OrderName") %>' placeholder="Descrizione"></asp:TextBox>
                                    </div>
                                </div>
                            </div>--%>
                            <div class="col-xl-12 d-flex">
                                <div class="form-group">
                                    <label for="txtData" class="sr-only">Beneficiario</label>
                                    <div class="col-md-12 col-sm-12 d-inline-block">
                                        <asp:DropDownList runat="server" ClientIDMode="static" CssClass="form-control custom-select my-select" ID="ddlToAuthor" onChange="setToAuthor()" SelectedValue='<%#  Bind("ToAuthor") %>'>
                                        </asp:DropDownList>
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
                                        runat="server" Text="Inserisci" />
                                </div>
                            </div>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <InsertItemTemplate>
                            <div style ="visibility: hidden">
                                <asp:TextBox runat="server" ID="txtFromAuthor" ClientIDMode="static" Text='<%#  Bind("FromAuthor") %>'></asp:TextBox>
                                <asp:TextBox runat="server" ID="txtToAuthor" ClientIDMode="static" Text='<%#  Bind("ToAuthor") %>'></asp:TextBox>
                            </div>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <InsertRowStyle BorderStyle="None" />
                <PagerStyle BorderStyle="None" />
                <RowStyle BorderStyle="None" />
            </asp:DetailsView>

            <asp:ObjectDataSource runat="server" ID="ObjectDataSource1"
                DataObjectTypeName="Storno"
                InsertMethod="InsertStorno"
                TypeName="OrderDB"
                ConflictDetection="CompareAllValues">
                <InsertParameters>
                    <asp:Parameter Name="storno" Type="Object"></asp:Parameter>
                </InsertParameters>
            </asp:ObjectDataSource>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>

    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script type="text/javascript">

        $(document).ready(function () {
            <% var serializer = new System.Web.Script.Serialization.JavaScriptSerializer(); %>
            var usersList = <%= serializer.Serialize(users) %>;

            $('#txtFromAuthor').val('<%= UserId %>');
            AppendValuesToObj('ddlToAuthor', usersList)
        });

        function AppendValuesToObj(objId, values) {
            $('#' + objId + '').append($('<option>', {
                value: '',
                text: '-'
            }));
            $.each(values, function (index, value) {
                $('#' + objId + '').append($('<option>', {
                    value: value.UserId,
                    text: value.userName
                }));
            })
        }

        function setToAuthor() {
            $('#txtToAuthor').val($('#ddlToAuthor').val());
        }
    </script>


</asp:Content>
