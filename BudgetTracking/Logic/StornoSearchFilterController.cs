using BudgetTracking.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BudgetTracking.Logic
{
    [Serializable()]
    public class StornoSearchFilterController: IFilterController
    {
        public StornoSearchFilter srcFilter;
        public StornoSearchFilterController(StornoSearchFilter filter)
        {
            this.srcFilter = filter;
        }
        public string AppendFilters(string tableAlias)
        {
            string sqlWhere = "";

            if (srcFilter.StornoDataFrom != null)
                sqlWhere += String.Format(" AND COALESCE({0}.DATE,DATEADD(year, -1, getdate()))>=CAST('{1}' AS DATE) ", tableAlias, srcFilter.StornoDataFrom.ToString());
            if (srcFilter.StornoDataTo != null)
                sqlWhere += String.Format(" AND COALESCE({0}.DATE,DATEADD(year, +1, getdate()))<=CAST('{1}' AS DATE) ", tableAlias, srcFilter.StornoDataTo.ToString());
            if (srcFilter.StornoDataCreationFrom != null)
                sqlWhere += String.Format(" AND COALESCE({0}.CREATION_DATE,DATEADD(year, -1, getdate()))>=CAST('{1}' AS DATE) ", tableAlias, srcFilter.StornoDataCreationFrom.ToString());
            if (srcFilter.StornoDataCreationTo != null)
                sqlWhere += String.Format(" AND COALESCE({0}.CREATION_DATE,DATEADD(year, +1, getdate()))<=CAST('{1}' AS DATE) ", tableAlias, srcFilter.StornoDataCreationTo.ToString());

            return sqlWhere;
        }
    }
}