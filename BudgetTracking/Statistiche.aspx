<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Statistiche.aspx.cs" Inherits="BudgetTracking.Statistiche" %>

<asp:Content ID="Content1" ContentPlaceHolderID="OrdersContentPlaceHolder" runat="server">

    <div class="input-group">
        <div class="form-outline">
            <button type="button" class="btn btn-light" data-toggle="modal" data-target=".bd-filter-modal-lg">Filters</button>
        </div>
        <button type="submit" class="btn btn-primary" runat="server" onclick="request(this)">
            <i class="fas fa-search"></i>
        </button>
    </div>

    <div class="modal fade bd-filter-modal-lg" tabindex="-1" role="dialog" aria-labelledby="filterModal" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <div class="form-control">
                    <div class="form-row">
                        <p>Data</p>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <input runat="server" id="flt_OrderDataFrom" name="flt_FromData" ClientIDMode="static" class="datepicker-field form-control" dataformatstring="{0:dd/MM/yyyy}" placeholder="Da" />
                        </div>

                        <div class="form-group">
                            <input runat="server" id="flt_OrderDataTo" name="flt_ToData" ClientIDMode="static" class="datepicker-field form-control" dataformatstring="{0:dd/MM/yyyy}" placeholder="A" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function request(target) {
            console.log("Ciao");
            var filters = getFilters();
            console.log(filters);
            console.log(JSON.stringify(filters));
            __doPostBack(target, JSON.stringify(filters))
        }

        function getFilters(){
            return filters =
            {
                  "OrderDataFrom": $('#flt_OrderDataFrom').val()
                , "OrderDataTo": $('#flt_OrderDataTo').val()
            };
        }
    </script>
</asp:Content>
