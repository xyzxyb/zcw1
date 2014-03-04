using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class asp_include_rxcp : System.Web.UI.UserControl
{
    protected DataTable dt_cltp = new DataTable();   //材料名字,存放地址(材料多媒体信息表)     
    DataConn objConn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
         dt_cltp = objConn.GetDataTable("select 存放地址,材料名称,cl_id from 材料多媒体信息表 where  是否上头条='是' and 媒体类型 = '图片' and 大小='小' and cl_id in(select cl_id from 材料表 where 类型='主打')");
    }		
        
}