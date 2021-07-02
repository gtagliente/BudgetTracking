<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BudgetTracking.Default" MasterPageFile="~/Site1.Master" EnableEventValidation="false" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="OrdersContentPlaceHolder" runat="server">

    <%--<header class="jumbotron"><%-- image set in site.css </header>--%>
    <main>
        <form id="form1" class="form-horizontal">

            <div class="input-group">
                <div class="form-outline">
                    <button type="button" class="btn btn-light" data-toggle="modal" data-target=".bd-filter-modal-lg">Filters</button>
                </div>
                <button type="submit" class="btn btn-primary" runat="server" onclick="request(this)">
                    <i class="fas fa-search"></i>
                </button>
            </div>

            <div class="container">
                <div class="modal fade bd-filter-modal-lg" tabindex="-1" role="dialog" aria-labelledby="filterModal" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">

                            <div class="form-control">
                                <div class="form-row">
                                    <p>Data</p>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <input runat="server" id="flt_OrderDataFrom" name="flt_FromData" clientidmode="static" class="datepicker-field form-control" dataformatstring="{0:dd/MM/yyyy}" placeholder="Da" />
                                    </div>

                                    <div class="form-group">
                                        <input runat="server" id="flt_OrderDataTo" name="flt_ToData" clientidmode="static" class="datepicker-field form-control" dataformatstring="{0:dd/MM/yyyy}" placeholder="A" />
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <br />
                <div class="row">
                    <div class="col-lg-12">
                        <div class="table-responsive">
                            <asp:GridView ID="GridView1" runat="server"
                                AutoGenerateColumns="False" DataKeyNames="OrderId"
                                OnPreRender="GridView1_PreRender"
                                OnRowDeleted="GridView1_RowDeleted"
                                OnPageIndexChanging="GridView1_PageIndexChanging"
                                CssClass="table table-bordered table-condensed table-hover table-striped" AllowPaging="True" PageSize="10">
                                <%--<HeaderStyle CssClass="thead-dark" />--%>
                                <Columns>
                                    <asp:BoundField DataField="OrderId" HeaderText="ID"
                                        ReadOnly="True" Visible="false"></asp:BoundField>
                                    <asp:BoundField DataField="OrderDate" HeaderText="Data"
                                        SortExpression="OrderDate" DataFormatString="{0:dd/MM/yyyy}">
                                        <%--<ItemStyle CssClass="visible-lg" />
                                        <HeaderStyle CssClass="visible-lg" />--%>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OrderName" HeaderText="Descrizione"
                                        SortExpression="OrderName">
                                        <%--<ItemStyle CssClass="visible-lg" />
                                        <HeaderStyle CssClass="visible-lg" />--%>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OrderAmount" HeaderText="Totale"
                                        SortExpression="OrderName">
                                        <%-- <ItemStyle CssClass="hidden-xs" />
                                        <HeaderStyle CssClass="hidden-xs" />--%>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OrderAuthor" HeaderText="Author"
                                        SortExpression="OrderAuthor">
                                        <%-- <ItemStyle CssClass="hidden-xs" />
                                        <HeaderStyle CssClass="hidden-xs" />--%>
                                    </asp:BoundField>
                                    <%--<asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="col-xl-12 d-flex">
                                                <div class="form-group">
                                                    <asp:Button ID="BtnDelete" CssClass="btn btn-primary"
                                                        CommandName="Delete"
                                                        CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                                        runat="server" Text="Elmina"/>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>--%>
                                    <asp:CommandField ButtonType="Link" CausesValidation="false"
                                        ShowDeleteButton="true" >
                                        <%--<ItemStyle CssClass="hidden-sm hidden-xs" />
                                        <HeaderStyle CssClass="hidden-sm hidden-xs" />--%>
                                    </asp:CommandField>
                                </Columns>
                                <AlternatingRowStyle CssClass="altRow" />
                                <EditRowStyle CssClass="warning" />
                            </asp:GridView>
                            <!-- <asp:ObjectDataSource runat="server" ID="ObjectDataSource1"
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
                            </asp:ObjectDataSource>-->
                        </div>
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

                <div class="form-group">
                    <div class="col-xs-12 col-sm-offset-1">
                        <asp:DataList ID="dlBalance" runat="server"
                            DataKeyField="Importo"
                            UseAccessibleHeader="true"
                            CssClass="table table-bordered table-striped table-condensed">
                            <HeaderTemplate>
                                <span class="col-xs-3">Totale</span>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <span class="col-xs-3"><%# Eval("Author") %></span>
                                <br>
                                <br>

                                <span class="col-xs-3">Bilancio: <%# Eval("Importo") %></span>
                                <br>
                                <div class="progress" style="border: 1px solid #dee2e6;">
                                    <div class='<%# (Convert.ToDouble(Eval("Importo"))<0) ? "progress-bar bg-success": "progress-bar bg-danger"%>'
                                        runat="server"
                                        id="progressBar"
                                        role="progressbar"
                                        style='<%# "width:" + Eval("Percentuale") +"%;"%>'
                                        aria-valuenow='<%# Eval("Percentuale") %>' aria-valuemin="0"
                                        aria-valuemax="100">
                                    </div>
                                </div>
                            </ItemTemplate>
                            <HeaderStyle CssClass="bg-halloween" />
                        </asp:DataList>
                    </div>
                </div>

                <div id="ProgessBars">
                </div>
        </form>
    </main>
    </div>
    <script type="text/javascript">
        function request(target) {
            var filters = getFilters();
            __doPostBack("FiltersSearch", JSON.stringify(filters))
        }

        function getFilters() {
            return filters =
            {
                "OrderDataFrom": $('#flt_OrderDataFrom').val()
                , "OrderDataTo": $('#flt_OrderDataTo').val()
            };
        }

        function test() {
            console.log("test");
        }
    </script>
</asp:Content>
