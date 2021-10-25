using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BudgetTracking.DataVisualization
{
    public partial class Statements : System.Web.UI.Page
    {
        public ObjectDataSource StatsDataSource;

        protected void Page_Load(object sender, EventArgs e)
        {
            BindAverage();
        }

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
    }
}