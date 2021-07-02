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
using System.Web;
using Microsoft.AspNet.Identity;
using System.Data.Common;
using System.Net.Configuration;
using BudgetTracking.Logic;

[DataObject(true)]
public class OrderDB
{
    public List<Order> orderList;

    [DataObjectMethod(DataObjectMethodType.Select)]
    public List<Order> GetOrders(List<IFilterController> filterList)
    {
        orderList = new List<Order>();

        string sql = " SELECT O.System_Id,O.Date,O.Order_Name,O.Order_Amount,U.UserName Author "
            + " FROM Orders O Inner join AspNetUsers U on (O.Author = U.ID) ";
        foreach (IFilterController filter in filterList)
            sql += filter.AppendFilters("O");

        sql += " ORDER BY Date DESC  ";
        using (SqlConnection con = new SqlConnection(GetConnectionString()))
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                Order order;
                while (dr.Read())
                {
                    order = new Order();
                    order.OrderId = Convert.ToInt32(dr["System_Id"]);
                    order.OrderDate = Convert.ToDateTime(dr["Date"]);
                    order.OrderName = dr["Order_Name"].ToString();
                    order.OrderAmount = dr["Order_Amount"].ToString();
                    order.OrderAuthor = dr["Author"].ToString();
                    orderList.Add(order);
                }
                dr.Close();
            }
        }
        return orderList;
    }

    [DataObjectMethod(DataObjectMethodType.Insert)]
    public static void InsertOrder(Order order)
    {
        string sql = "INSERT INTO Orders "
            + "(Date, Order_Name, Order_Amount,Author) "
            + "VALUES (@Date, @OrderName, @OrderAmount,@Author)";
        
        using (SqlConnection con = new SqlConnection(GetConnectionString()))
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("Date", order.OrderDate);
                cmd.Parameters.AddWithValue("OrderName", order.OrderName);
                cmd.Parameters.AddWithValue("OrderAmount", order.OrderAmount);
                cmd.Parameters.AddWithValue("Author", HttpContext.Current.User.Identity.GetUserId());
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }

    [DataObjectMethod(DataObjectMethodType.Delete)]
    public  int DeleteOrder(Order order)
    {
        int deleteCount = 0;
        string sql = "DELETE FROM Orders "
            + " WHERE System_Id = @System_Id ";
            
        using (SqlConnection con = new SqlConnection(GetConnectionString()))
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("System_Id", order.OrderId);
                con.Open();
                deleteCount = cmd.ExecuteNonQuery();
            }
        }
        return deleteCount;
    }

    [DataObjectMethod(DataObjectMethodType.Insert)]
    public static int InsertStorno(Storno storno)
    {
        int insertCount = 0;
        string sql = " INSERT INTO STORNI (DATE,FROM_AUTHOR,TO_AUTHOR,ORDER_AMOUNT) "
                    + " VALUES(@DATA,@FROM_AUTHOR,@TO_AUTHOR,@ORDER_AMOUNT) ";

        DbProviderFactory provider = DbProviderFactories.GetFactory("System.Data.SqlClient");
        using (DbConnection cn = provider.CreateConnection())
        {
            cn.ConnectionString = GetConnectionString();
            cn.Open();
            DbCommand cmd = provider.CreateCommand();
            cmd.CommandText = sql;

            DbParameter param = cmd.CreateParameter();
            param.ParameterName = "DATA";
            param.DbType = DbType.Date;
            param.Value = storno.Data;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "FROM_AUTHOR";
            param.DbType = DbType.String;
            param.Value = storno.FromAuthor;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "TO_AUTHOR";
            param.DbType = DbType.String;
            param.Value = storno.ToAuthor;
            cmd.Parameters.Add(param);

            param = cmd.CreateParameter();
            param.ParameterName = "ORDER_AMOUNT";
            param.DbType = DbType.Double;
            param.Value = storno.OrderAmount;
            cmd.Parameters.Add(param);
            cmd.Connection = cn;
            insertCount = cmd.ExecuteNonQuery();
            cn.Close();
        }
        
        return insertCount;
    }

    private static string GetConnectionString()
    {
        return ConfigurationManager.ConnectionStrings
            ["BudgetTrackingConnection"].ConnectionString;
    }

}

