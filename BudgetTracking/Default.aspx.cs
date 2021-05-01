using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace Ch17CategoryMaintenance
{
    public partial class Default : System.Web.UI.Page
    {
        public TMP_Average[] averageArray;
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
            // test();
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
        }

        protected void ObjectDataSource1_GetAffectedRows(object sender, ObjectDataSourceStatusEventArgs e)
        {
            e.AffectedRows = Convert.ToInt32(e.ReturnValue);
        }

        protected void test()
         {
            Double sum=0;

            int OrderAmountcellIndex= -1;
            int a = GridView1.PageIndex;
            int r = 0;

            //GridView1.Rows[0].Cells.Cast<ControlCollection>().Where
            for (int k=0; k< GridView1.Rows[0].Cells.Count; k++) 
                if (((System.Web.UI.WebControls.DataControlFieldCell)GridView1.Rows[0].Cells[k]).ContainingField.HeaderText == "Totale") { OrderAmountcellIndex = k; break; }


            GridView1.AllowPaging = false;
            GridView1.DataBind();
            List < TMP_Average > list = new List<TMP_Average>();

            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                sum += Convert.ToDouble(GridView1.Rows[i].Cells[OrderAmountcellIndex].Text);
                list.Add(new TMP_Average
                {
                    Importo = Convert.ToDouble(GridView1.Rows[i].Cells[OrderAmountcellIndex].Text),
                    Author = GridView1.Rows[i].Cells[4].Text
                });
                r++;
            }

            // You can select some checkboxex on gridview over here..
            var authorsList = list
                            .GroupBy(x => x.Author)
                            .Select(y => new TMP_Average
                            {
                                Author = y.First().Author,
                                Importo = (sum / 3) - y.Sum(c => c.Importo),
                                Percentuale = Math.Abs((y.Sum(c => c.Importo) - (sum / 3)) / sum) * 100,
                                Positivo = (y.Sum(c => c.Importo) - (sum / 3)) / sum > 0 ? true : false
                            }).ToList();

           


            DbProviderFactory provider = DbProviderFactories.GetFactory("System.Data.SqlClient");
            using (DbConnection cn = provider.CreateConnection())
            {
                DataTable dt = new DataTable();
                cn.ConnectionString = ConfigurationManager.ConnectionStrings
                         ["BudgetTrackingConnection"].ConnectionString;

                String sql = "SELECT * FROM STORNI ";
                //DataTable dt = utility.Custom_Query("SELECT * FROM " + tablename + " WHERE ISNULL(STATO,'') = ''");

                DbCommand cmd = cn.CreateCommand();
                cmd.CommandText = sql;

                DbDataAdapter da = provider.CreateDataAdapter();
                da.SelectCommand = cmd;
                da.Fill(dt);

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
                
                TMP_Average tmp;
                foreach (Storno storno in storniList)
                {
                    tmp = authorsList.FirstOrDefault(l => l.Author == storno.FromAuthor);
                    tmp.Importo -= storno.OrderAmount;

                    tmp = authorsList.FirstOrDefault(l => l.Author == storno.ToAuthor);
                    tmp.Importo += storno.OrderAmount;
                }

                authorsList.ForEach(y => y.Percentuale = (Math.Abs(y.Importo) / sum) * 100);

                this.averageArray = authorsList.ToArray();


            }




                GridView1.AllowPaging = true;
            GridView1.DataBind();

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