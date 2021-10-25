using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Storno
{
    public int SystemId { get; set; }
    public DateTime Data { get; set; }
    public string FromAuthor { get; set; }
    public string FromAuthorUserName { get; set; }
    public string ToAuthor { get; set; }
    public string ToAuthorUserName { get; set; }
    public decimal OrderAmount { get; set; }

    public DateTime CreationDate { get; set; }
}