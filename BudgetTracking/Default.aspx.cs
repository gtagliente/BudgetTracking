using BudgetTracking.Logic;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace BudgetTracking
{
    public partial class Default : System.Web.UI.Page
    {
        public int deletingID;
        public TMP_Average[] averageArray;
        public ObjectDataSource StatsDataSource;
        public ObjectDataSource OrdersDataSource;
        public JavaScriptSerializer serializer1;
        List<IFilterController> currentFilters = new List<IFilterController>()
                                                    { new SearchFilterController(
                                                                new SearchFilter
                                                                {
                                                                    OrderDataFrom =Convert.ToDateTime("2021-05-01"),
                                                                    OrderDataTo = DateTime.Now
                                                                })
                                                    };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                ViewState["FiltersList"] = new List<IFilterController>()
                                                    { new SearchFilterController(
                                                                new SearchFilter
                                                                {
                                                                    OrderDataFrom =Convert.ToDateTime("2021-05-01"),
                                                                    OrderDataTo = DateTime.Now
                                                                })
                                                    };
            }

            serializer1 = new JavaScriptSerializer();
            serializer1.RegisterConverters(new[] { new ExtendedJavaScriptConverter<SearchFilter>() });

            BindAverage();
            BindOrders();
            
        }

//        TuoGridview.PageIndex = e.NewPageIndex
//TuoGridview.databind

        private void BindAverage()
        {
            StatsDataSource = new ObjectDataSource();
            StatsDataSource.ID = "StatsDataSource";
            StatsDataSource.DataObjectTypeName = "AverageModel";
            StatsDataSource.SelectMethod = "GetStats";
            StatsDataSource.TypeName = "StatsDB";
            //StatsDataSource.FilterExpression = "Stringa filtro";
            //StatsDataSource.SelectParameters.Add("param", "ciao");
            //StatsDataSource.Selecting += SqlSource_Selecting;
            StatsDataSource.DataBind();
            dlBalance.DataSource = StatsDataSource;
            dlBalance.DataBind();
        }

        public void BindOrders()
        {
            OrdersDataSource = new ObjectDataSource();
            OrdersDataSource.ID = "OrdersDataSource";
           // OrdersDataSource.DataObjectTypeName = "Order";
            OrdersDataSource.SelectMethod = "GetOrders";
            OrdersDataSource.TypeName = "OrderDB";
            //OrdersDataSource.FilterExpression = "Stringa filtro";
            //OrdersDataSource.SelectParameters.Add("param", "ciao");
            OrdersDataSource.Selecting += SqlSource_Selecting;
            OrdersDataSource.DeleteMethod += "DeleteOrder";
            OrdersDataSource.Deleting += this.Sql_Deleting;
            OrdersDataSource.DataBind();
            GridView1.DataSource = OrdersDataSource;
            GridView1.RowDeleting += RowDeleting;
            //GridView1.DeleteMethod = "DeleteOrder";
            GridView1.DataBind();
        }

        public void RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            OrdersDataSource.DeleteParameters.Add("index", GridView1.DataKeys[e.RowIndex].Value.ToString());
            OrdersDataSource.Delete();
            Response.Redirect(Request.RawUrl);
            //GridView1.DataKeys[e.RowIndex].Value
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
        }
        protected void GridView1_PreRender(object sender, EventArgs e)
        {
           // GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void ObjectDataSource1_GetAffectedRows(object sender, ObjectDataSourceStatusEventArgs e)
        {
            e.AffectedRows = Convert.ToInt32(e.ReturnValue);
        }

        public void Sql_Deleting(object src, ObjectDataSourceMethodEventArgs e)
        {
            Order order = new Order { OrderId = Convert.ToInt32(e.InputParameters["index"]) };
            e.InputParameters.Clear();
            e.InputParameters["order"] = order;
        }

        public void SqlSource_Selecting(object src, ObjectDataSourceSelectingEventArgs e)
        {

            if (Request.Form["__EVENTTARGET"] == "FiltersSearch")
            {
                string jsonArgs = Request.Form["__EVENTARGUMENT"];

               
                SearchFilter flt = serializer1.Deserialize<SearchFilter>(jsonArgs);
                ViewState["FiltersList"] =  new List<IFilterController>()
                    { new SearchFilterController(flt)};
            }
            
            e.InputParameters["filterList"] = (List<IFilterController>)ViewState["FiltersList"];
        }


        protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception != null) {
                lblError.Text = DatabaseErrorMessage(e.Exception);
                e.ExceptionHandled = true;
                e.KeepInEditMode = true;
            }
            else if (e.AffectedRows == 0)
                lblError.Text = ConcurrencyErrorMessage();
        }

        protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception != null) {
                lblError.Text = DatabaseErrorMessage(e.Exception);
                e.ExceptionHandled = true;
            }
            else if (e.AffectedRows == 0)
                lblError.Text = ConcurrencyErrorMessage();
        }

        protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception != null) {
                lblError.Text = DatabaseErrorMessage(e.Exception);
                e.ExceptionHandled = true;
            }
        }

        private string DatabaseErrorMessage(Exception ex)
        {
            string msg = $"<b>A database error has occurred:</b> {ex.Message}";
            if (ex.InnerException != null)
                msg += $"<br />Message: {ex.InnerException.Message}";
            return msg; 
        }
        private string ConcurrencyErrorMessage() {
            return "Another user may have updated that category. Please try again";
        }

       

    }
    public class TMP_Average
    {
        public double Importo { get; set; }
        public string Author { get; set; }

        public double Percentuale { get; set; }

        public bool Positivo { get; set; }
    }

    public class Storno
    {
       public int SystemId { get; set; }
        public DateTime Data { get; set; }
        public string FromAuthor { get; set; }
        public string ToAuthor { get; set; }
        public double OrderAmount { get; set; }
    }
}