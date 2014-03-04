
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
            DataConn conn4=new DataConn();
            string yjfl_id = Request["id"];   //获取大类传过来的分类编码

            DataTable dt_ejfl = conn4.GetDataTable("select 显示名字,分类编码 from 材料分类表 where left(分类编码,2)='"+yjfl_id+"'and len(分类编码)='4'");
            
            Response.Write("<option value='0'>选择大类</option>");
            foreach(System.Data.DataRow row in dt_ejfl.Rows) 
            {
                Response.Write("<option value='"+row["分类编码"]+"'>"+row["显示名字"]+"</option>");
            }

%>