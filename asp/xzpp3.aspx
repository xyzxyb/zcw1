
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);          
            String yh_id = Session["yh_id"].ToString();
         

            //����Ʒ��д�����ݿ�
            {
                conn.Open(); 
                string gys_id = Request["gys_id"]; 				
                string brandname = Request["brandname"];            //Ʒ������
                string yjflname = Request["yjflname"];              //�󼶷�������               
                string ejflname = Request["ejflname"];              //������������
                string grade = Request.Form["grade"];               //�ȼ�
                string scope = Request["scope"];                    //��Χ       
                string flname = ejflname;
                if (flname.Equals("0"))  flname = yjflname;
               
                string str_insert = "insert into  Ʒ���ֵ� (Ʒ������,�Ƿ�����,scs_id,�������,�ȼ�,��Χ,yh_id) values('" + brandname + "',1,'"+gys_id+"','" + flname + "','" + grade + "','" + scope + "','"+yh_id+"' ) ";
            
                //Response.Write(sql);
				SqlCommand cmd_insert= new SqlCommand(str_insert, conn);
                cmd_insert.ExecuteNonQuery();	
			
                String str_update = "update Ʒ���ֵ� set pp_id= (select myID from Ʒ���ֵ� where Ʒ������='"+brandname+"'),"  
                    +" fl_id = (select fl_id from ���Ϸ���� where �������='"+flname+"')," 
                    +" ������ = (select ��Ӧ�� from ���Ϲ�Ӧ����Ϣ�� where gys_id = '"+gys_id+"'),"
                    +" �������� = (select ��ʾ���� from ���Ϸ���� where ������� = '"+flname+"')"
                    +" where Ʒ������='"+brandname+"'";
                SqlCommand cmd_update= new SqlCommand(str_update, conn);
                int ret = (int)cmd_update.ExecuteNonQuery();	
				//Response.Write(str_update);
                conn.Close();

    
            }	                    
		
     %>

    <body>
        <p>
        </p> 
         <p>
        </p>
       
        <a style="color: Red" onclick="clickMe()">��ϲ��������Ʒ�Ƴɹ����뷵��; </a>
        <script>
            function clickMe() {
                window.close();
                opener.location.reload();

            }
        </script>
        

    </body>





