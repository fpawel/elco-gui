using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace setsdlg
{
    public partial class Form1 : Form
    {        
        public Form1()
        {
            InitializeComponent();
            this.propertyGrid1.SelectedObject = new Config { };
        }

        private void PropertyGrid1_PropertyValueChanged(object s, PropertyValueChangedEventArgs e)
        {
            if(e.ChangedItem.PropertyDescriptor.Name == "AmbientTemperature")
            {
                var v = (double)e.ChangedItem.Value;
                if (v>200 || v < -100)
                {
                    var o = (Config)this.propertyGrid1.SelectedObject;
                    o.AmbientTemperature = (double)e.OldValue;
                }
            }
        }
    }
}
