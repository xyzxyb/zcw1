<!--   
      �ļ���:xzclym3 
      �������: id (�����������)
-->
	  
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);

            string ejfl_id = Request["id"];   //��ȡС�ഩ�����ķ������
            string id = ejfl_id.ToString().Substring(0, 2);
			
			
            SqlDataAdapter da_pp = new SqlDataAdapter("select Ʒ������,pp_id from Ʒ���ֵ� where left(�������,2)='"+id+"'", conn);
            DataSet ds_pp = new DataSet();
            da_pp.Fill(ds_pp, "Ʒ���ֵ�");            
            DataTable dt_pp = ds_pp.Tables[0];        
            Response.Write("<option value='0'>ѡ��Ʒ��</option>");
            foreach(System.Data.DataRow row in dt_pp.Rows) 
            {
                Response.Write("<option value='"+row["pp_id"]+"'>"+row["Ʒ������"]+"</option>");
            }			
			
		
			
		

%>