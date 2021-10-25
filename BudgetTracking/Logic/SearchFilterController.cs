using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Linq;
using System.Web;

namespace BudgetTracking.Logic
{
    [Serializable()]
    public class SearchFilterController : IFilterController
    {
        public SearchFilter srcFilter;
        public SearchFilterController(SearchFilter filter)
        {
            this.srcFilter = filter;
        }
        public string AppendFilters(string tableAlias)
        {
            string sqlWhere = "";

           if (srcFilter.OrderDataFrom != null)
                sqlWhere += String.Format(" AND {0}.DATE>=CAST('{1}' AS DATE) ", tableAlias,srcFilter.OrderDataFrom.ToString());
           if (srcFilter.OrderDataTo != null)
                sqlWhere += String.Format(" AND {0}.DATE<=CAST('{1}' AS DATE) ", tableAlias,srcFilter.OrderDataTo.ToString());
            if (srcFilter.OrderDataCreationFrom != null)
                sqlWhere += String.Format(" AND {0}.CREATION_DATE>=CAST('{1}' AS DATE) ", tableAlias, srcFilter.OrderDataCreationFrom.ToString());
            if (srcFilter.OrderDataCreationTo != null)
                sqlWhere += String.Format(" AND {0}.CREATION_DATE<=CAST('{1}' AS DATE) ", tableAlias, srcFilter.OrderDataCreationTo.ToString());

            return sqlWhere;
        }

    }
}