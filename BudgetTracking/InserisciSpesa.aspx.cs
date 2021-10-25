using BudgetTracking.Logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BudgetTracking
{
    public partial class InserisciSpesa : System.Web.UI.Page
    {
        public OrderDB OrdersDataSource;
        protected void Page_Load(object sender, EventArgs e)
        {
            BindOrders();
        }

        public void BindOrders()
        {
            //OrdersDataSource = new ObjectDataSource();
            //OrdersDataSource.ID = "OrdersDataSource";
            //OrdersDataSource.DataObjectTypeName = "Order";
            //OrdersDataSource.SelectMethod = "GetOrders";
            //OrdersDataSource.TypeName = "OrderDB";
            //OrdersDataSource.InsertMethod = "InsertOrder";
            //OrdersDataSource.InsertParameters.Clear();
            //OrdersDataSource.FilterExpression = "Stringa filtro";
            //OrdersDataSource.SelectParameters.Add("param", "ciao");
            //OrdersDataSource.DataBind();
            //DetailsView1.DataSource = OrdersDataSource;
            DetailsView1.ItemInserting += new DetailsViewInsertEventHandler(this.DetailsView1_ItemInserting);
            //DetailsView1.ItemInserting += DetailsView1_ItemInserting;
            //DetailsView1.DataBind();
        }

        public void DetailsView1_ItemInserting(object src, DetailsViewInsertEventArgs e)
        {
            JavaScriptSerializer serializer1 = new JavaScriptSerializer();
            serializer1.RegisterConverters(new[] { new ExtendedJavaScriptConverter<Order>() });
            Order order = serializer1.Deserialize<Order>(Request.Form["__EVENTARGUMENT"]);
            order.CreationDate = DateTime.Now;
            OrderDB.InsertOrder(order);
            Response.Redirect("/Default.aspx");
        }
    }
}