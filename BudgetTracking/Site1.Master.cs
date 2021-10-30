using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;


namespace BudgetTracking
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        public string basePath;
        protected void Page_Load(object sender, EventArgs e)
        {
             basePath = Request.ApplicationPath;
        }

        protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut(DefaultAuthenticationTypes.ApplicationCookie);
        }
    }
}