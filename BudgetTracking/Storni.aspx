<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Storni.aspx.cs" Inherits="BudgetTracking.Storni" MasterPageFile="~/Site1.Master" EnableEventValidation="false" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="OrdersContentPlaceHolder" runat="server">
    <style>
        .ListGridViewHeader {
            color:white;
            background: forestgreen!important;
        }
        .btn-primary{
            background: forestgreen!important;
        }

        .btn-light{
            border:0.5px solid black;
        }

        .table-striped>tbody>tr:nth-child(odd)>td {
            background-color: #CCFFCC; 
        }

        .table>tbody>tr:last-child{
            background-color: forestgreen; 
            color: white;
        }

        .table>tbody>tr:last-child>td>table{
            border-collapse: separate;
            border-spacing: 20px 0;
        }

        .table>tbody>tr:last-child>td>table>tbody>tr>td{
            padding:2px 8px;
        }
    </style>
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

            <%--<div class="container">--%>
                <div class="modal fade bd-filter-modal-lg" tabindex="-1" role="dialog" aria-labelledby="filterModal" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">

                            <div class="form-control">
                                <div class="form-row">
                                    <p>Data Storno</p>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <input runat="server" id="flt_StornoDataFrom" name="flt_FromData" clientidmode="static" class="datepicker-field form-control" dataformatstring="{0:dd/MM/yyyy}" placeholder="Da" />
                                    </div>

                                    <div class="form-group">
                                        <input runat="server" id="flt_StornoDataTo" name="flt_ToData" clientidmode="static" class="datepicker-field form-control" dataformatstring="{0:dd/MM/yyyy}" placeholder="A" />
                                    </div>
                                </div>

                            </div>

                            <div class="form-control">
                                <div class="form-row">
                                    <p>Data Inserimento</p>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <input runat="server" id="flt_StornoCreationDataFrom" name="flt_StornoCreationDataFrom" clientidmode="static" class="datepicker-field form-control" dataformatstring="{0:dd/MM/yyyy}" placeholder="Da" />
                                    </div>

                                    <div class="form-group">
                                        <input runat="server" id="flt_StornoCreationDataTo" name="flt_StornoCreationDataTo" clientidmode="static" class="datepicker-field form-control" dataformatstring="{0:dd/MM/yyyy}" placeholder="A" />
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <br />
                <div class="row">
                    <div class="col-md-12 col-lg-10 col-xl-8">
                        <div class="table-responsive">
                            <asp:GridView ID="GridView1" runat="server"
                                AutoGenerateColumns="False" DataKeyNames="SystemId"
                                OnPreRender="GridView1_PreRender"
                                OnPageIndexChanging="GridView1_PageIndexChanging"
                                CssClass="table table-bordered table-condensed table-hover table-striped" AllowPaging="True" PageSize="10">
                                <%--<HeaderStyle CssClass="thead-dark" />--%>
                                <Columns>
                                    <asp:BoundField DataField="SystemId" HeaderText="ID"
                                        ReadOnly="True" Visible="false"></asp:BoundField>
                                    <asp:BoundField DataField="Data" HeaderText="Data"
                                        SortExpression="Data" DataFormatString="{0:dd/MM/yyyy}">
                                        <%--<ItemStyle CssClass="visible-lg" />
                                        <HeaderStyle CssClass="visible-lg" />--%>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="FromAuthorUserName" HeaderText="Da"
                                        SortExpression="FromAuthorUserName">
                                        <%--<ItemStyle CssClass="visible-lg" />
                                        <HeaderStyle CssClass="visible-lg" />--%>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ToAuthorUserName" HeaderText="A"
                                        SortExpression="ToAuthorUserName">
                                        <%-- <ItemStyle CssClass="hidden-xs" />
                                        <HeaderStyle CssClass="hidden-xs" />--%>
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OrderAmount" HeaderText="Importo"
                                        SortExpression="OrderAmount"></asp:BoundField>
                                    <%-- <asp:CommandField ButtonType="Link" CausesValidation="false"
                                        ShowDeleteButton="true" >--%>
                                    <%--<ItemStyle CssClass="hidden-sm hidden-xs" />
                                        <HeaderStyle CssClass="hidden-sm hidden-xs" />
                                    </asp:CommandField>--%>
                                </Columns>
                                <HeaderStyle CssClass="ListGridViewHeader" HorizontalAlign="Left" />
                                <AlternatingRowStyle CssClass="altRow" />
                                <EditRowStyle CssClass="warning" />
                            </asp:GridView>

                        </div>
                    </div>
                </div>
            <%--</div>--%>
        </form>
    </main>
    <script type="text/javascript">
        function request(target) {
            var filters = getFilters();
            __doPostBack("FiltersSearch", JSON.stringify(filters))
        }

        function getFilters() {
            return filters =
            {
                "StornoDataFrom": $('#flt_StornoDataFrom').val()
                , "StornoDataTo": $('#flt_StornoDataTo').val()
                , "StornoDataCreationFrom": $('#flt_StornoCreationDataFrom').val()
                , "StornoDataCreationTo": $('#flt_StornoCreationDataTo').val()
            };
        }
    </script>
</asp:Content>
