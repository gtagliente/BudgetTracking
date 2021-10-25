using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Script.Serialization;

namespace BudgetTracking.Logic
{
    public class ExtendedJavaScriptConverter<T> : JavaScriptConverter where T : new()
    {
        private const string _dateFormat = "dd/MM/yyyy";

        public override IEnumerable<Type> SupportedTypes
        {
            get
            {
                return new[] { typeof(T) };
            }
        }

        public override object Deserialize(IDictionary<string, object> dictionary, Type type, JavaScriptSerializer serializer)
        {
            T p = new T();
            var props = typeof(T).GetProperties();

            foreach (string key in dictionary.Keys)
            {
                var prop = props.Where(t => t.Name == key).FirstOrDefault();
                if (prop != null)
                {
                    if (prop.PropertyType == typeof(DateTime?) || prop.PropertyType == typeof(DateTime))
                    {
                        if (String.IsNullOrEmpty(dictionary[key].ToString())) prop.SetValue(p, null, null);
                        else prop.SetValue(p, DateTime.ParseExact(dictionary[key] as string, _dateFormat, DateTimeFormatInfo.InvariantInfo), null);

                    }
                    else if(prop.PropertyType == typeof(decimal?) || prop.PropertyType == typeof(decimal))
                    {
                        prop.SetValue(p,Convert.ToDecimal(dictionary[key] as string, CultureInfo.InvariantCulture),null);
                    }
                    else
                    {
                        prop.SetValue(p, dictionary[key], null);
                    }
                }
            }

            return p;
        }

        public override IDictionary<string, object> Serialize(object obj, JavaScriptSerializer serializer)
        {
            T p = (T)obj;
            IDictionary<string, object> serialized = new Dictionary<string, object>();

            foreach (PropertyInfo pi in typeof(T).GetProperties())
            {
                if (pi.PropertyType == typeof(DateTime))
                {
                    serialized[pi.Name] = ((DateTime)pi.GetValue(p, null)).ToString(_dateFormat);
                }
                else
                {
                    serialized[pi.Name] = pi.GetValue(p, null);
                }

            }

            return serialized;
        }

        public static JavaScriptSerializer GetSerializer()
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            serializer.RegisterConverters(new[] { new ExtendedJavaScriptConverter<T>() });

            return serializer;
        }
    }

}