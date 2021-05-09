using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(BudgetTracking.Startup))]
namespace BudgetTracking
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
