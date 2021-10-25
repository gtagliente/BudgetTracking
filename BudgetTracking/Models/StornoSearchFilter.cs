using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BudgetTracking.Models
{
    [Serializable()]
    public class StornoSearchFilter
    {
        public DateTime? StornoDataFrom { get; set; }
        public DateTime? StornoDataTo { get; set; }
        public DateTime? StornoDataCreationFrom { get; set; }
        public DateTime? StornoDataCreationTo { get; set; }
    }
}