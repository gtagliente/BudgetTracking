using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


public class Order
{
    public int OrderId { get; set; }
    public DateTime OrderDate { get; set; }
    public string OrderName { get; set; }
    public string OrderAmount { get; set; }
    public string OrderAuthor { get; set; }
    public DateTime CreationDate { get; set; }
}
