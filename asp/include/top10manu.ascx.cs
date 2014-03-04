using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class asp_include_top10manu : System.Web.UI.UserControl
{
    public List<Manufacturer> Items { get; set; }
    public class Manufacturer
    {
        public string Gys_id { get; set; }
        public string Type { get; set; }
        public string Manufacturers { get; set; }
    }
    protected DataTable dt = new DataTable(); //最受关注的供应商(材料供应商信息表)	
    DataConn objConn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
           dt=objConn.GetDataTable("select distinct top 10 供应商 ,gys_id,单位类型 from 材料供应商信息表 where 是否启用=1 order by gys_id");

            this.Items = new List<Manufacturer>();
            for (int x = 0; x < dt.Rows.Count; x++)
            {
                DataRow dr = dt.Rows[x];
                Manufacturer mf = new Manufacturer();
                mf.Manufacturers = Convert.ToString(dr["供应商"]);
                mf.Type = Convert.ToString(dr["单位类型"]);
                mf.Gys_id = Convert.ToString(dr["gys_id"]);
                this.Items.Add(mf);
            }
        }
    }
}