using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class asp_include_header2 : System.Web.UI.UserControl
{
    protected DataTable dt_yh = new DataTable(); //用户名字(用户表)  
    DataConn objConn = new DataConn();
    public string SQL = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        HttpCookie QQ_id = Request.Cookies["QQ_id"];
        if (QQ_id != null)
        {
            SQL = "select 姓名 from 用户表 where QQ_id='" + QQ_id.Value + "'";
            dt_yh = objConn.GetDataTable(SQL);
        }
    }	      
}