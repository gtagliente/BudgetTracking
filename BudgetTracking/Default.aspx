<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Ch17CategoryMaintenance.Default" MasterPageFile="~/Site1.Master" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="OrdersContentPlaceHolder" runat="server">
    <div class="container">
        <%--<header class="jumbotron"><%-- image set in site.css </header>--%>
        <main>
            <form id="form1" runat="server" class="form-horizontal">

                <div class="row">
                    <div class="col-xs-12">
                        <asp:GridView ID="GridView1" runat="server"
                            AutoGenerateColumns="False" DataKeyNames="OrderId"
                            DataSourceID="ObjectDataSource1"
                            OnPreRender="GridView1_PreRender"
                            OnRowDeleted="GridView1_RowDeleted"
                            CssClass="table table-bordered table-condensed table-hover table-striped" AllowPaging="True" PageSize="10">
                            <HeaderStyle CssClass="thead-dark" />
                            <Columns>
                                <asp:BoundField DataField="OrderId" HeaderText="ID"
                                    ReadOnly="True">
                                    <ItemStyle CssClass="col-xs-1" />
                                </asp:BoundField>
                                <asp:BoundField DataField="OrderDate" HeaderText="Data"
                                    SortExpression="OrderDate">
                                    <ItemStyle CssClass="col-xs-2" />
                                </asp:BoundField>
                                <asp:BoundField DataField="OrderName" HeaderText="Descrizione"
                                    SortExpression="OrderName">
                                    <ItemStyle CssClass="col-xs-2" />
                                </asp:BoundField>
                                <asp:BoundField DataField="OrderAmount" HeaderText="Totale"
                                    SortExpression="OrderName">
                                    <ItemStyle CssClass="col-xs-3" />
                                </asp:BoundField>
                                <asp:BoundField DataField="OrderAuthor" HeaderText="Author"
                                    SortExpression="OrderAuthor">
                                    <ItemStyle CssClass="col-xs-2" />
                                </asp:BoundField>
                                <%-- <asp:CommandField ButtonType="Link" CausesValidation="false"
                            ShowEditButton="true">
                            <ItemStyle CssClass="col-xs-1 text-danger" />
                        </asp:CommandField>--%>
                                <asp:CommandField ButtonType="Link" CausesValidation="false"
                                    ShowDeleteButton="true">
                                    <ItemStyle CssClass="col-xs-2" />
                                </asp:CommandField>
                            </Columns>
                            <AlternatingRowStyle CssClass="altRow" />
                            <EditRowStyle CssClass="warning" />
                        </asp:GridView>
                        <asp:ObjectDataSource runat="server" ID="ObjectDataSource1"
                            DataObjectTypeName="Order" DeleteMethod="DeleteOrder"
                            InsertMethod="InsertOrder"
                            OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetOrders" TypeName="OrderDB"
                            ConflictDetection="CompareAllValues"
                            OnDeleted="ObjectDataSource1_GetAffectedRows"
                            OnUpdated="ObjectDataSource1_GetAffectedRows">
                            <UpdateParameters>
                                <asp:Parameter Name="original_Order" Type="Object"></asp:Parameter>
                                <asp:Parameter Name="order" Type="Object"></asp:Parameter>
                            </UpdateParameters>
                        </asp:ObjectDataSource>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-6">

                        <p>
                            <asp:Label ID="lblError" runat="server" EnableViewState="false"
                                CssClass="text-danger"></asp:Label>
                        </p>





                    </div>
                </div>


                <div id="ProgessBars">
                </div>


            </form>
        </main>
    </div>
</asp:Content>
