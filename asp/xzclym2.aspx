<!--
       �ļ���:xzclym2.aspx
	   ������� : �������(��λ)
-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
         DataConn conn=new DataConn();
            string yjfl_id = Request["id"];   //��ȡ���ഩ�����ķ������

           DataTable dt_ejfl  = conn.GetDataTable("select ��ʾ����,������� from ���Ϸ���� where left(�������,2)='"+yjfl_id+"'and len(�������)='4'");
           
            Response.Write("<option value='0'>ѡ��С��</option>");
            foreach(System.Data.DataRow row in dt_ejfl.Rows) 
            {
                Response.Write("<option value='"+row["�������"]+"'>"+row["��ʾ����"]+"</option>");
            }

%>