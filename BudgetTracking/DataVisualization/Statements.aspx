<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Statements.aspx.cs" Inherits="BudgetTracking.DataVisualization.Statements" %>

<asp:Content ID="Content1" ContentPlaceHolderID="OrdersContentPlaceHolder" runat="server">



    <div class="col-md-8 col-xl-6">
        <div class="form-group">
            <div class="col-xs-12 col-sm-offset-1">
                <asp:DataList ID="dlBalance" runat="server"
                    DataKeyField="Importo"
                    UseAccessibleHeader="true"
                    CssClass="table table-bordered table-striped table-condensed">
                    <headertemplate>
                                <span class="col-xs-3">Totale</span>
                            </headertemplate>
                    <itemtemplate>
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
                            </itemtemplate>
                    <headerstyle cssclass="bg-halloween" />
                </asp:DataList>
            </div>
        </div>
    </div>




</asp:Content>
