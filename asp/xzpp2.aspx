
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<%
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);

            string yjfl_id = Request["id"];   //��ȡ���ഫ�����ķ������

            SqlDataAdapter da_ejfl = new SqlDataAdapter("select ��ʾ����,������� from ���Ϸ���� where left(�������,2)='"+yjfl_id+"'and len(�������)='4'", conn);
            DataSet ds_ejfl = new DataSet();
            da_ejfl.Fill(ds_ejfl, "���Ϸ����");            
            DataTable dt_ejfl = ds_ejfl.Tables[0];        
            Response.Write("<option value='0'>ѡ�����</option>");
            foreach(System.Data.DataRow row in dt_ejfl.Rows) 
            {
                Response.Write("<option value='"+row["�������"]+"'>"+row["��ʾ����"]+"</option>");
            }

%>