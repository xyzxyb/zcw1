using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class asp_include_menu : System.Web.UI.UserControl
{
    public List<FLObject> Items1 { get; set; }
    public List<FLObject> Items2 { get; set; }
    public List<FLObject> Items3 { get; set; }

    protected DataTable dt = new DataTable(); //取一级分类名称前七条
    protected DataTable dt1 = new DataTable(); //取二级分类名称全部
    protected DataTable dt2 = new DataTable();  //取一级分类名称前七条之后的所有
    DataConn objConn = new DataConn();

    protected void Page_Load(object sender, EventArgs e)
    {
       dt = objConn.GetDataTable("select 显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=2 and 分类编码 in (08,07,02,04,05,01,06) order by 分类编码 desc");

        dt1=objConn.GetDataTable("select distinct  显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=4 ");

        dt2=objConn.GetDataTable("select 显示名字,分类编码 from 材料分类表 where 是否启用=1 and len(分类编码)=2 and 分类编码 not in(08,07,02,04,05,01,06 )");

        ////数据表DataTable转集合                  
        this.Items1 = new List<FLObject>();
        this.Items2 = new List<FLObject>();
        this.Items3 = new List<FLObject>();

        for (int x = 0; x < dt.Rows.Count; x++)
        {
            DataRow dr2 = dt.Rows[x];

            if (Convert.ToString(dr2["分类编码"]).Length == 2)
            {
                FLObject item = new FLObject();
                item.Name = Convert.ToString(dr2["显示名字"]);
                item.Sid = Convert.ToString(dr2["分类编码"]);
                this.Items1.Add(item);
            }
        }
        for (int x = 0; x < dt2.Rows.Count; x++)
        {
            DataRow dr = dt2.Rows[x];

            if (Convert.ToString(dr["分类编码"]).Length == 2)
            {
                FLObject item = new FLObject();
                item.Name = Convert.ToString(dr["显示名字"]);
                item.Sid = Convert.ToString(dr["分类编码"]);
                this.Items3.Add(item);
            }
        }
        for (int x = 0; x < dt1.Rows.Count; x++)
        {
            DataRow dr2 = dt1.Rows[x];
            if (Convert.ToString(dr2["分类编码"]).Length == 4)
            {
                FLObject item = new FLObject();
                item.Name = Convert.ToString(dr2["显示名字"]);
                item.Sid = Convert.ToString(dr2["分类编码"]);
                this.Items2.Add(item);
            }
        }

    }

    public class FLObject
    { //属性
        public string Sid { get; set; }
        public string Name { get; set; }
        //public string Uid { get; set; }		
    }
   
}