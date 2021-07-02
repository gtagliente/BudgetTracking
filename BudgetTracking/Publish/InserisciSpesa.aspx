<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InserisciSpesa.aspx.cs" Inherits="BudgetTracking.InserisciSpesa" MasterPageFile="~/Site1.Master" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="OrdersContentPlaceHolder" runat="server">

    <h1 class="login-form-main-message">Inserisci Spesa</h1>


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
                                        <asp:TextBox runat="server" ID="txtData" CssClass="datepicker-field form-control" Text='<%#  Bind("OrderDate") %>' DataFormatString="{0:dd/MMM/yyyy}" placeholder="Data"></asp:TextBox>
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
                                        runat="server" Text="Inserisci"  />
                                </div>
                            </div>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <InsertRowStyle BorderStyle="None" />
                <PagerStyle BorderStyle="None" />
                <RowStyle BorderStyle="None" />
            </asp:DetailsView>

            <asp:ObjectDataSource runat="server" ID="ObjectDataSource1"
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
            </asp:ObjectDataSource>
        </form>
    </div>


</asp:Content>
