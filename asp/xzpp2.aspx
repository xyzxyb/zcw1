
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
            DataConn conn4=new DataConn();
            string yjfl_id = Request["id"];   //��ȡ���ഫ�����ķ������

            DataTable dt_ejfl = conn4.GetDataTable("select ��ʾ����,������� from ���Ϸ���� where left(�������,2)='"+yjfl_id+"'and len(�������)='4'");
            
            Response.Write("<option value='0'>ѡ�����</option>");
            foreach(System.Data.DataRow row in dt_ejfl.Rows) 
            {
                Response.Write("<option value='"+row["�������"]+"'>"+row["��ʾ����"]+"</option>");
            }

%>