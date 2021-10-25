using BudgetTracking.Logic;
using BudgetTracking.Models;
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
    public partial class Storni : System.Web.UI.Page
    {
        public int deletingID;
        public TMP_Average[] averageArray;
        public ObjectDataSource StatsDataSource;
        public ObjectDataSource OrdersDataSource;
        public JavaScriptSerializer serializer1;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                ViewState["FiltersList"] = new List<IFilterController>()
                                                    { new StornoSearchFilterController(
                                                                new StornoSearchFilter
                                                                {
                                                                    StornoDataFrom =Convert.ToDateTime("2021-05-01"),
                                                                    StornoDataTo = DateTime.Now
                                                                })
                                                    };
            }

            serializer1 = new JavaScriptSerializer();
            serializer1.RegisterConverters(new[] { new ExtendedJavaScriptConverter<StornoSearchFilter>() });

            BindStorni();

        }


        public void BindStorni()
        {
            OrdersDataSource = new ObjectDataSource();
            OrdersDataSource.ID = "StorniDataSource";
            // OrdersDataSource.DataObjectTypeName = "Order";
            OrdersDataSource.SelectMethod = "GetStorni";
            OrdersDataSource.TypeName = "OrderDB";
            //OrdersDataSource.FilterExpression = "Stringa filtro";
            //OrdersDataSource.SelectParameters.Add("param", "ciao");
            OrdersDataSource.Selecting += SqlSource_Selecting;
            //OrdersDataSource.DeleteMethod += "DeleteOrder";
            //OrdersDataSource.Deleting += this.Sql_Deleting;
            OrdersDataSource.DataBind();
            GridView1.DataSource = OrdersDataSource;
            //GridView1.RowDeleting += RowDeleting;
            //GridView1.DeleteMethod = "DeleteOrder";
            GridView1.DataBind();
        }

        //public void RowDeleting(object sender, GridViewDeleteEventArgs e)
        //{
        //    OrdersDataSource.DeleteParameters.Add("index", GridView1.DataKeys[e.RowIndex].Value.ToString());
        //    OrdersDataSource.Delete();
        //    Response.Redirect(Request.RawUrl);
        //    //GridView1.DataKeys[e.RowIndex].Value
        //}
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

        //public void Sql_Deleting(object src, ObjectDataSourceMethodEventArgs e)
        //{
        //    Order order = new Order { OrderId = Convert.ToInt32(e.InputParameters["index"]) };
        //    e.InputParameters.Clear();
        //    e.InputParameters["order"] = order;
        //}

        public void SqlSource_Selecting(object src, ObjectDataSourceSelectingEventArgs e)
        {

            if (Request.Form["__EVENTTARGET"] == "FiltersSearch")
            {
                string jsonArgs = Request.Form["__EVENTARGUMENT"];


                StornoSearchFilter flt = serializer1.Deserialize<StornoSearchFilter>(jsonArgs);
                ViewState["FiltersList"] = new List<IFilterController>()
                    { new StornoSearchFilterController(flt)};
            }

            e.InputParameters["filterList"] = (List<IFilterController>)ViewState["FiltersList"];
        }


        //protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        //{
        //    if (e.Exception != null)
        //    {
        //        lblError.Text = DatabaseErrorMessage(e.Exception);
        //        e.ExceptionHandled = true;
        //        e.KeepInEditMode = true;
        //    }
        //    else if (e.AffectedRows == 0)
        //        lblError.Text = ConcurrencyErrorMessage();
        //}

        //protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
        //{
        //    if (e.Exception != null)
        //    {
        //        lblError.Text = DatabaseErrorMessage(e.Exception);
        //        e.ExceptionHandled = true;
        //    }
        //    else if (e.AffectedRows == 0)
        //        lblError.Text = ConcurrencyErrorMessage();
        //}

        //protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        //{
        //    if (e.Exception != null)
        //    {
        //        lblError.Text = DatabaseErrorMessage(e.Exception);
        //        e.ExceptionHandled = true;
        //    }
        //}

        private string DatabaseErrorMessage(Exception ex)
        {
            string msg = $"<b>A database error has occurred:</b> {ex.Message}";
            if (ex.InnerException != null)
                msg += $"<br />Message: {ex.InnerException.Message}";
            return msg;
        }
        private string ConcurrencyErrorMessage()
        {
            return "Another user may have updated that category. Please try again";
        }



    }

}