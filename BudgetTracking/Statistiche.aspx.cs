using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.Json.Serialization;
using System.Diagnostics;
using System.Globalization;
using Newtonsoft.Json;
using System.Web.Script.Serialization;
using System.Reflection;
using BudgetTracking.Logic;
using System.Web.Services;

namespace BudgetTracking
{
    public partial class Statistiche : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string jsonArgs = Request.Form["__EVENTARGUMENT"];

                //JavaScriptSerializer serializer1 = new JavaScriptSerializer();
                //serializer1.RegisterConverters(new[] { new ExtendedJavaScriptConverter<Filters>() });
                //Filters flt = serializer1.Deserialize<Filters>(jsonArgs);
                
            }
            //getMonthlyExpenses();
            //BindAverage();
        }
        [WebMethod]
        public static string getMonthlyExpenses()
        {
            return OrderDB.GetMonthExpenses();
        }

        //private void BindAverage()
        //{
        //    StatsDataSource = new ObjectDataSource();
        //    StatsDataSource.ID = "StatsDataSource";
        //    StatsDataSource.DataObjectTypeName = "AverageModel";
        //    StatsDataSource.SelectMethod = "GetStats";
        //    StatsDataSource.TypeName = "StatsDB";
        //    //StatsDataSource.FilterExpression = "Stringa filtro";
        //    //StatsDataSource.SelectParameters.Add("param", "ciao");
        //    //StatsDataSource.Selecting += SqlSource_Selecting;
        //    StatsDataSource.DataBind();
        //    dlBalance.DataSource = StatsDataSource;
        //    dlBalance.DataBind();
        //}
    }
}