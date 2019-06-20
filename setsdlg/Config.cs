using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel;
using System.Globalization;
using System.Reflection;

namespace setsdlg
{
    public class Config
    {
        [Category("СОМ порты")]
        [DisplayName("СОМ порт стенда")]
        [Description("Имя СОМ порта, к которому подключены касеты стенда")]
        [TypeConverter(typeof(ComportNamesConverter))]
        public string ComportProducts { get; set; }

        [Category("СОМ порты")]
        [DisplayName("СОМ порт газового блок")]
        [Description("Имя СОМ порта, к которому подключен газового блока")]
        [TypeConverter(typeof(ComportNamesConverter)) ]
        public string ComportGas { get; set; }

        [Category("Оборудование")]
        [DisplayName("Тип микросхемы памяти ЭХЯ")]
        [Description("Тип микросхемы памяти ЭХЯ: 24LC16, 24LC64 либо 24LC256")]
        [TypeConverter(typeof(ChipTypeConverter))]
        public string ChipType { get; set; }

        [Category("Оборудование")]
        [DisplayName("Температура окружающей среды,⁰С")]
        [Description("Значение температуры окружающей среды в ⁰С. Охоаждающий копрессор будут включен в случае, если текущая температура темрмокамеры выше данного значения, а значение уставки ниже.")]
        [TypeConverter(typeof(FloatConverter))]
        public double AmbientTemperature { get; set; }


        public class ComportNamesConverter : StringConverter
        {
            public override bool GetStandardValuesSupported( ITypeDescriptorContext context)
            {
                return true;
            }
            public override bool GetStandardValuesExclusive(ITypeDescriptorContext context)
            {
                return true;
            }
            public override StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
            {
                return new StandardValuesCollection(System.IO.Ports.SerialPort.GetPortNames());
            }
        }

        public class ChipTypeConverter : StringConverter
        {
            public override bool GetStandardValuesSupported(ITypeDescriptorContext context)
            {
                return true;
            }
            public override bool GetStandardValuesExclusive(ITypeDescriptorContext context)
            {
                return true;
            }
            public override StandardValuesCollection GetStandardValues(ITypeDescriptorContext context)
            {
                return new StandardValuesCollection(new[] { "24LC16", "24LC64", "24LC256" });
            }
        }

        public class FloatConverter : DoubleConverter
        {
            public override object ConvertFrom(ITypeDescriptorContext context, CultureInfo culture, object value)
            {
                try
                {
                    return base.ConvertFrom(context, culture, value);
                }
                catch (Exception e)
                {
                    PropertyInfo pi = context.GetType().GetProperty("Value");
                    var v = (double)pi.GetValue(context);
                    return base.ConvertFrom(context, culture, v.ToString());
                }
            }

            public override object ConvertTo(ITypeDescriptorContext context, CultureInfo culture, object value, Type destinationType)
            {
                try
                {
                    return base.ConvertTo(context, culture, value, destinationType);
                }
                catch (Exception e)
                {
                    // Process the exception (for example, Log(e)) or Debug.Assert()
                    throw;
                }
            }
        }
    }
}
