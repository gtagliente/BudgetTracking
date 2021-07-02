using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
// be sure to include these using directives
using System.Configuration;
using System.Data;
using System.ComponentModel;
using System.Data.Common;
using BudgetTracking;

[DataObject(true)]
public static class StatsDB
{

    [DataObjectMethod(DataObjectMethodType.Select)]
    public static List<AverageModel> GetStats()
    {
        List<AverageModel> authorsList = new List<AverageModel>();
        DbProviderFactory provider = DbProviderFactories.GetFactory("System.Data.SqlClient");
        using (DbConnection cn = provider.CreateConnection())
        {
            double sum=0;
            string sqlTotaliSpesa = @" SELECT A.USERNAME,A.ID,SUM(ORDER_AMOUNT) AS TOTSPESO " +
                                    "  from orders o inner join AspNetUsers a on (o.author = a.id) " +
                                    "  group by a.username,a.Id ";

            DataTable dt = new DataTable();
            cn.ConnectionString = GetConnectionString();

            DbCommand cmd = cn.CreateCommand();
            cmd.CommandText = sqlTotaliSpesa;

            DbDataAdapter da = provider.CreateDataAdapter();
            da.SelectCommand = cmd;
            da.Fill(dt);

            foreach (DataRow row in dt.Rows) 
                sum += Convert.ToDouble(row["TOTSPESO"]);

            
           
            authorsList = (from DataRow dr in dt.Rows
             select new AverageModel()
             {
                 Author = Convert.ToString(dr["USERNAME"]),
                 AuthorId = Convert.ToString(dr["ID"]),
                 Importo = (sum/3) - Convert.ToDouble(dr["TOTSPESO"]),
                 Percentuale = Convert.ToInt32(Math.Abs((Convert.ToDouble(dr["TOTSPESO"]) - (sum / 3)) / sum) * 100),
                 Positivo = (Convert.ToDouble(dr["TOTSPESO"]) - (sum / 3)) / sum > 0 ? true : false
             }).ToList();

            String sql = " SELECT * FROM STORNI ";
            //DataTable dt = utility.Custom_Query("SELECT * FROM " + tablename + " WHERE ISNULL(STATO,'') = ''");
            dt = new DataTable();
            DbCommand cmdStorni= cn.CreateCommand();
            cmdStorni.CommandText = sql;

            DbDataAdapter daStorni = provider.CreateDataAdapter();
            daStorni.SelectCommand = cmdStorni;
            daStorni.Fill(dt);

            List<Storno> storniList = new List<Storno>();

            storniList = (from DataRow dr in dt.Rows
                          select new Storno()
                          {
                              SystemId = Convert.ToInt32(dr["SYSTEM_ID"]),
                              Data = Convert.ToDateTime(dr["DATE"]),
                              FromAuthor = Convert.ToString(dr["FROM_AUTHOR"]),
                              ToAuthor = Convert.ToString(dr["TO_AUTHOR"]),
                              OrderAmount = Convert.ToDouble(dr["ORDER_AMOUNT"])
                          }).ToList();

            AverageModel tmp;
            foreach (Storno storno in storniList)
            {
                tmp = authorsList.FirstOrDefault(l => l.AuthorId == storno.FromAuthor);
                tmp.Importo -= storno.OrderAmount;

                tmp = authorsList.FirstOrDefault(l => l.AuthorId == storno.ToAuthor);
                tmp.Importo += storno.OrderAmount;
            }

            authorsList.ForEach(y => y.Percentuale = Convert.ToInt32(((Math.Abs(y.Importo) / sum) * 100)));

        }

        return authorsList;
    }


    private static string GetConnectionString()
    {
        return ConfigurationManager.ConnectionStrings
        ["BudgetTrackingConnection"].ConnectionString;
    }

}

public class Storno
{
    public int SystemId { get; set; }
    public DateTime Data { get; set; }
    public string FromAuthor { get; set; }
    public string ToAuthor { get; set; }
    public double OrderAmount { get; set; }
}