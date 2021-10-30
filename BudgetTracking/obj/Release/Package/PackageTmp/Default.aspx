<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BudgetTracking.Default" MasterPageFile="~/Site1.Master" EnableEventValidation="false" %>

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
                                    <p>Data</p>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <input runat="server" id="flt_OrderDataFrom" name="flt_OrderDataCreationFrom" clientidmode="static" class="datepicker-field form-control" dataformatstring="{0:dd/MM/yyyy}" placeholder="Da" />
                                    </div>

                                    <div class="form-group">
                                        <input runat="server" id="flt_OrderDataTo" name="flt_OrderDataTo" clientidmode="static" class="datepicker-field form-control" dataformatstring="{0:dd/MM/yyyy}" placeholder="A" />
                                    </div>
                                </div>
                            </div>

                            <div class="form-control">
                                <div class="form-row">
                                    <p>Data Inserimento</p>
                                </div>
                                <div class="form-row">
                                    <div class="form-group">
                                        <input runat="server" id="flt_OrderDataCreationFrom" name="flt_OrderDataCreationFrom" clientidmode="static" class="datepicker-field form-control" dataformatstring="{0:dd/MM/yyyy}" placeholder="Da" />
                                    </div>

                                    <div class="form-group">
                                        <input runat="server" id="flt_OrderDataCreationTo" name="flt_OrderDataCreationTo" clientidmode="static" class="datepicker-field form-control" dataformatstring="{0:dd/MM/yyyy}" placeholder="A" />
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
                                AutoGenerateColumns="False" DataKeyNames="OrderId"
                                OnPreRender="GridView1_PreRender"
                                OnPageIndexChanging="GridView1_PageIndexChanging"
                                CssClass="table table-bordered table-condensed table-hover table-striped" AllowPaging="True" PageSize="10">

                                <Columns>
                                    <asp:BoundField DataField="OrderId" HeaderText="ID"
                                        ReadOnly="True" Visible="false"></asp:BoundField>
                                    <asp:BoundField DataField="OrderDate" HeaderText="Data"
                                        SortExpression="OrderDate" DataFormatString="{0:dd/MM/yyyy}">
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OrderName" HeaderText="Descrizione"
                                        SortExpression="OrderName">
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OrderAmount" HeaderText="Totale"
                                        SortExpression="OrderName">
                                    </asp:BoundField>
                                    <asp:BoundField DataField="OrderAuthor" HeaderText="Author"
                                        SortExpression="OrderAuthor">
                                    </asp:BoundField>
                                </Columns>
                                <HeaderStyle CssClass="ListGridViewHeader" HorizontalAlign="Left" />
                                <AlternatingRowStyle CssClass="altRow" />
                                <EditRowStyle CssClass="warning" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
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
                "OrderDataFrom": $('#flt_OrderDataFrom').val()
                , "OrderDataTo": $('#flt_OrderDataTo').val()
                , "OrderDataCreationFrom": $('#flt_OrderDataCreationFrom').val()
                , "OrderDataCreationTo": $('#flt_OrderDataCreationTo').val()
            };
        }

        function test() {
            console.log("test");
        }
    </script>
</asp:Content>
