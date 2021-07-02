using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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
        }
    }

    public class UserView
    {
        public string UserId { get; set; }
        public string userName { get; set; }
    }
}