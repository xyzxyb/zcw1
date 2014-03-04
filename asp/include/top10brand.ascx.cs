using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;

public partial class asp_include_top10brand: System.Web.UI.UserControl
{
    protected DataTable dt = new DataTable();
    DataConn objConn = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        //string constr = ConfigurationManager.ConnectionStrings["DBServerName"].ConnectionString;
        objConn = new DataConn();
        dt=objConn.GetDataTable("select distinct top 10 品牌名称 ,pp_id from 品牌字典 where 是否启用=1 ");
    }	
}