
	  
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
           DataConn conn2= new DataConn();
			
			string flsx_id = Request["id"];   //��ȡ�������ƴ������ķ���id 
            //�ȸ��ݴ�������flsx_id ����������			
            DataTable dt_flsxid  =conn2.GetDataTable("select ������� from ���Ϸ�������ֵ�� where flsx_id='"+flsx_id+"'");    //���� ����
			
            string clflsx_id = Convert.ToString(dt_flsxid.Rows[0]["�������"]);	  //��ȡ�������	
         
			//�Է������   �ͷ������ƴ������ķ���id ��ѯ����ֵ 
			DataTable dt_flsx_id = conn2.GetDataTable("select ����ֵ from ���Ϸ�������ֵ��	 where flsx_id='"+flsx_id+"'and �������='"+clflsx_id+"' ");    //���� ����
			
            string clflsx_id1 = Convert.ToString(dt_flsx_id.Rows[0]["����ֵ"]);	  //��ȡ�������
            Response.Write(clflsx_id1);
			
            //Response.Write("<input type="text">"+clflsx_id+"</input>");
            //Response.Write(clflsx_id);
	        //Response.Write("<option value=''>"+clflsx_id1+"</option>");
%>