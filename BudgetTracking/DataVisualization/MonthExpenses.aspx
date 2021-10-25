<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="MonthExpenses.aspx.cs" Inherits="BudgetTracking.DataVisualization.MonthExpenses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="OrdersContentPlaceHolder" runat="server">

    <div class="col-md-6 col-xl-5">
        <canvas id="myChart" width="400" height="400"></canvas>
    </div>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>

    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>

        function getMonthAmounts(data) {
            //var text = '[["gennaio",	"464.33"],["febbraio","494.05"],["marzo",	"388.93"],["aprile",	"743.77"],["maggio",	"571.97"],["giugno",	"375.00"],["luglio",	"444.00"],["ottobre",	"342.92"],["novembre","712.77"],["dicembre","722.00"]]';
            var text = data;
            var myArr = JSON.parse(text);
            return myArr;
        }

        function getLabelsArr(DataMatrix) {
            var LabelArr = new Array();
            for (var x = 0; x < DataMatrix.length; x++) {
                LabelArr[x] = DataMatrix[x].mese;
            }
            return LabelArr;
        }

        function getValuesArr(DataMatrix) {
            var ValuesArr = new Array();
            for (var x = 0; x < DataMatrix.length; x++) {
                ValuesArr[x] = parseFloat(DataMatrix[x].mmExp);
            }
            return ValuesArr;
        }


        $.ajax({

            url: "MonthExpenses.aspx/getMonthlyExpenses",
            type: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                console.log("Statistiche " + response);
                MonthlyExpensesChart(response.d)
            },
            error: function () {
                console.log("Statistiche Error");;
            }
        });

        function MonthlyExpensesChart(data) {
            var ctx = document.getElementById('myChart').getContext('2d');
            var DataMatrix = getMonthAmounts(data);
            var labelsArr = getLabelsArr(DataMatrix);
            var valuesArr = getValuesArr(DataMatrix);
            var myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    //labels: ['Gennaio', 'Febbraio', 'Marzo', 'Aprile', 'Maggio', 'Giugno','Luglio','Agosto','Settembre','Ottobre','Novembre','Dicembre'],
                    labels: labelsArr,
                    datasets: [{
                        label: 'Totale',
                        data: valuesArr,
                        backgroundColor: 'forestgreen',
                        borderColor: 'forestgreen',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }
    </script>
</asp:Content>
