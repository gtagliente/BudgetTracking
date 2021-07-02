using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Web;

[Serializable()]
public class SearchFilter
{
    public DateTime OrderDataFrom { get; set; }
    public DateTime OrderDataTo { get; set; }
}