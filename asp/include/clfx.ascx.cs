using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class asp_include_clfx : System.Web.UI.UserControl
{
       protected DataTable dt = new DataTable();
        protected DataTable dt1 = new DataTable();
        protected DataTable dt2 = new DataTable();
        protected DataTable dt3 = new DataTable();
		DataConn objConn=new DataConn();
        public string SQL="";
        protected void Page_Load(object sender, EventArgs e)
        {
          SQL="select wz_id,标题 from 文章表 where 文档类型='材料发现' ";
         dt=objConn.GetDataTable(SQL);

            SQL="select wz_id,标题 from 文章表 where 文档类型='材料导购'";
            dt1=objConn.GetDataTable(SQL);

	        SQL="select wz_id,标题 from 文章表 where 文档类型='材料评测' ";                   
            dt2 = objConn.GetDataTable(SQL);
			
	        SQL="select wz_id,标题 from 文章表 where 文档类型='材料百科' ";
           dt3=objConn.GetDataTable(SQL);		
        }
}