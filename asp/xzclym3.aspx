<!--   
      �ļ���:xzclym3 
      �������: id (�����������)
-->
	  
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
           DataConn conn1=new DataConn();
            string ejfl_id = Request["id"];   //��ȡС�ഩ�����ķ������
            string id = ejfl_id.ToString().Substring(0, 2);
			
			
            DataTable dt_pp = conn1.GetDataTable("select Ʒ������,pp_id from Ʒ���ֵ� where left(�������,2)='"+id+"'");
          
            Response.Write("<option value='0'>ѡ��Ʒ��</option>");
            foreach(System.Data.DataRow row in dt_pp.Rows) 
            {
                Response.Write("<option value='"+row["pp_id"]+"'>"+row["Ʒ������"]+"</option>");
            }			
			
		
			
		

%>