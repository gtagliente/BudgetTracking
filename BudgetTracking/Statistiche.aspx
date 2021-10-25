<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Statistiche.aspx.cs" Inherits="BudgetTracking.Statistiche" %>

<asp:Content ID="Content1" ContentPlaceHolderID="OrdersContentPlaceHolder" runat="server">

    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">

    <%-- Grid System. fonti:
        https://www.bootdey.com/snippets/view/bs4-image-box 
    --%>
    <div class="row">
        <div class="col-md-6 col-xl-3">
            <div class="image-box image-box--shadowed white-bg style-2 mb-4">
                <div class="overlay-container">
                    <img src="https://pnp.github.io/sp-dev-fx-controls-react/assets/BarChart.png" alt="" style="height:200px; width:380px">
                    <a href="#" class="overlay-link"></a>
                </div>
                <div class="body">
                    <h5 class="font-weight-bold my-2">Medie Mensili</h5>
                    <div class="row d-flex align-items-center">
                        <div class="col-6 text-right">
                            <a href="/DataVisualization/MonthExpenses.aspx" class="btn radius-50 btn-gray-transparent btn-animated">Visualizza <i class="fa fa-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6 col-xl-3">
            <div class="image-box image-box--shadowed white-bg style-2 mb-4">
                <div class="overlay-container">
                    <img src="https://ramonak.io/static/eb54dbc5916216c674253e424e094342/4e3e1/react-progress-bar.jpg" alt="" style="height:200px; width:380px">
                    <a href="#" class="overlay-link"></a>
                </div>
                <div class="body">
                    <h5 class="font-weight-bold my-2">Bilancio</h5>
                    <div class="row d-flex align-items-center">
                        <div class="col-6 text-right">
                            <a href="/DataVisualization/Statements.aspx" class="btn radius-50 btn-gray-transparent btn-animated">Visualizza <i class="fa fa-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
