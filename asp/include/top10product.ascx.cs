using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class asp_include_top10product : System.Web.UI.UserControl
{
    protected DataTable dt = new DataTable();
    DataConn objConn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
        dt=objConn.GetDataTable("select top 10 显示名,cl_id,材料编码,fl_id,分类编码 from 材料表 order by fl_id ");
    }	
}