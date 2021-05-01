<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InserisciSpesa.aspx.cs" Inherits="Ch17CategoryMaintenance.InserisciSpesa" MasterPageFile="~/Site1.Master" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>


<asp:Content ID="Content1" ContentPlaceHolderID="OrdersContentPlaceHolder" runat="server">

    <h1 class="login-form-main-message">Inserisci Spesa</h1>


    <div class="row">
        <form id="form1" runat="server" class="main-login-form">

            <asp:DetailsView ID="DetailsView1" runat="server" AllowPaging="True"
                DataSourceID="ObjectDataSource1" AutoGenerateRows="False" 
                DefaultMode="Insert" DataKeyNames="OrderID" BorderStyle="None" GridLines="None">
                <Fields>
                    <asp:TemplateField>
                        <%-- <ItemTemplate>
                            <asp:Label runat="server" ID="lblData" Text='View'></asp:Label>
                        </ItemTemplate>--%>
                        <InsertItemTemplate>
                            <!-- <asp:Calendar ID="Calend" runat="server"
                                SelectedDate='<%#  Bind("OrderDate") %>'></asp:Calendar>-->
                            <%--  SelectedDate='<%#  Bind("OrderDate") %>'
                                VisibleDate='<%# Eval("OrderDate") %>'--%>
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
                    <%--<asp:BoundField DataField="OrderDate" HeaderText="Data"  dataformatstring="{0:dd/MM/yyyy}"/>--%>
                    <%--<asp:BoundField DataField="OrderName" HeaderText="Descrizione" />
                    <asp:BoundField DataField="OrderAmount" HeaderText="Importo" />
                    <asp:BoundField DataField="OrderAuthor" HeaderText="Autore" />--%>
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
                                <div class="form-group" style="width:100%">
                                    <label for="txtAutore" class="sr-only">Autore</label>
                                    <%--                                    
                                        <asp:TextBox runat="server" ID="txtAutore" CssClass="form-control" Text='<%#  Bind("OrderAuthor") %>' placeholder="Autore"></asp:TextBox>
                                    </div>--%>


                                    <div class="col-md-12 col-sm-12 d-inline-block">
                                        <asp:DropDownList ID="ColorList"
                                            AutoPostBack="False"
                                            runat="server"
                                            CssClass="form-control" 
                                            SelectedValue='<%# Bind("OrderAuthor") %>'>

                                            <asp:ListItem Selected="True" Value=""> - </asp:ListItem>
                                            <asp:ListItem  Value="1"> Gianluca</asp:ListItem>
                                            <asp:ListItem Value="2"> Marco </asp:ListItem>
                                            <asp:ListItem Value="3"> Vincenzo </asp:ListItem>

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
                                    <%--  <asp:CommandField ShowInsertButton="True" ShowDeleteButton="False"
                                ShowEditButton="False" ControlStyle-CssClass="btn btn-primary" />--%>
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
