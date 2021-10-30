using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using BudgetTracking.Logic;
using BudgetTracking.Models;
using Microsoft.AspNet.Identity;

namespace BudgetTracking
{
    public partial class InserisciStorno : System.Web.UI.Page
    {
        public List<UserView> users;
        public string UserId;
        protected void Page_Load(object sender, EventArgs e)
        {
            var context = new ApplicationDbContext();

            var allUsers = context.Users.ToList();
            this.UserId = HttpContext.Current.User.Identity.GetUserId();
            this.users = (from ApplicationUser user in allUsers
                                  select new UserView { UserId = user.Id, userName = user.UserName })
                                  .Where(x => x.userName != HttpContext.Current.User.Identity.GetUserName()).ToList();

            DetailsView1.ItemInserting += new DetailsViewInsertEventHandler(this.DetailsView1_ItemInserting);
        }
        public void DetailsView1_ItemInserting(object src, DetailsViewInsertEventArgs e)
        {
            JavaScriptSerializer serializer1 = new JavaScriptSerializer();
            serializer1.RegisterConverters(new[] { new ExtendedJavaScriptConverter<Storno>() });
            Storno storno = serializer1.Deserialize<Storno>(Request.Form["__EVENTARGUMENT"]);
            storno.FromAuthor = this.UserId;
            storno.CreationDate = DateTime.Now;
            OrderDB.InsertStorno(storno);
            Response.Redirect(String.Concat(Request.ApplicationPath.Equals("/") ? "" : Request.ApplicationPath,"/Storni.aspx"));
        }
    }

    public class UserView
    {
        public string UserId { get; set; }
        public string userName { get; set; }
    }
}