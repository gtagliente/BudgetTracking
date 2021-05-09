using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
// be sure to include these using directives
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.ComponentModel;


[DataObject(true)]
public static class StatsDB
{

    [DataObjectMethod(DataObjectMethodType.Select)]
    public static Stats GetStats()
    {
        //List<Order> orderList = new List<Order>();
        //Stats stats = new Stats();
        //string sql = "select sum(order_amount) totale from orders where author = 1 ";
           
        //using (SqlConnection con = new SqlConnection(GetConnectionString()))
        //{
        //    using (SqlCommand cmd = new SqlCommand(sql, con))
        //    {
        //        con.Open();
        //        SqlDataReader dr = cmd.ExecuteReader();
        //        Order order;
        //        while (dr.Read())
        //        {
        //            stats.Totale = Convert.ToDouble(dr["totale"]);
        //        }
        //        dr.Close();
        //    }
        //}
        return new Stats { Totale = 100 };
    }


    private static string GetConnectionString()
    {
        return ConfigurationManager.ConnectionStrings
        ["BudgetTrackingConnection"].ConnectionString;
    }
}
