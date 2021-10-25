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

namespace BudgetTracking.DataVisualization
{
    public partial class MonthExpenses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string getMonthlyExpenses()
        {
            return OrderDB.GetMonthExpenses();
        }
    }
}
