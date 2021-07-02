using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BudgetTracking.Logic
{
    public interface IFilterController
    {
         string AppendFilters( string tableAlias = null);
    }
}
