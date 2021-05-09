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

[DataObject(true)]
public class OrderDB
{
    public List<Order> orderList;

    [DataObjectMethod(DataObjectMethodType.Select)]
    public List<Order> GetOrders()
    {
        orderList = new List<Order>();
        string sql = "SELECT O.System_Id,O.Date,O.Order_Name,O.Order_Amount,U.UserName Author "
            + "FROM Orders O Inner join AspNetUsers U on (O.Author = U.ID) ORDER BY Date DESC";
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
    public static int DeleteCategory(Order order)
    {
        int deleteCount = 0;
        string sql = "DELETE FROM Orders "
            + "WHERE System_Id = @System_Id "
            + "AND Date = @Date "
            + "AND OrderName = @OrderName"
            + "AND OrderAmount = @OrderAmount"
            + "AND Author = @Author";
        using (SqlConnection con = new SqlConnection(GetConnectionString()))
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("System_Id", order.OrderId);
                cmd.Parameters.AddWithValue("Date", order.OrderDate);
                cmd.Parameters.AddWithValue("OrderName", order.OrderName);
                cmd.Parameters.AddWithValue("OrderAmount", order.OrderAmount);
                cmd.Parameters.AddWithValue("Author", order.OrderAuthor);
                con.Open();
                deleteCount = cmd.ExecuteNonQuery();
            }
        }
        return deleteCount;
    }

    /* [DataObjectMethod(DataObjectMethodType.Update)]
     public static int UpdateCategory(Order original_Order,
         Order order)
     {
         int updateCount = 0;
         string sql = "UPDATE Orders "
             + "SET  = @ShortName, "
             + "LongName = @LongName "
             + "LongName = @LongName "
             + "LongName = @LongName "
             + "WHERE CategoryID = @original_CategoryID "
             + "AND ShortName = @original_ShortName "
             + "AND LongName = @original_LongName";
         using (SqlConnection con = new SqlConnection(GetConnectionString()))
         {
             using (SqlCommand cmd = new SqlCommand(sql, con))
             {
                 cmd.Parameters.AddWithValue("ShortName", category.ShortName);
                 cmd.Parameters.AddWithValue("LongName", category.LongName);
                 cmd.Parameters.AddWithValue("original_CategoryID", 
                     original_Category.CategoryID);
                 cmd.Parameters.AddWithValue("original_ShortName",
                     original_Category.ShortName);
                 cmd.Parameters.AddWithValue("original_LongName",
                     original_Category.LongName);
                 con.Open();
                 updateCount = cmd.ExecuteNonQuery();
             }
         }
         return updateCount;
     }*/

    private static string GetConnectionString()
    {
        return ConfigurationManager.ConnectionStrings
            ["BudgetTrackingConnection"].ConnectionString;
    }

}

