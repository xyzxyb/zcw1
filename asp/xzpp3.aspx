
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    DataConn conn5=new DataConn();
    
            string yh_id = Session["yh_id"].ToString();
         

            //����Ʒ��д�����ݿ�
            {
              
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
			conn5.ExecuteSQL(str_insert,false);
			
                string str_update = "update Ʒ���ֵ� set pp_id= (select myID from Ʒ���ֵ� where Ʒ������='"+brandname+"'),"  
                    +" fl_id = (select fl_id from ���Ϸ���� where �������='"+flname+"')," 
                    +" ������ = (select ��Ӧ�� from ���Ϲ�Ӧ����Ϣ�� where gys_id = '"+gys_id+"'),"
                    +" �������� = (select ��ʾ���� from ���Ϸ���� where ������� = '"+flname+"')"
                    +" where Ʒ������='"+brandname+"'";
               
                int ret =conn5.ExecuteSQLForCount(str_update,true);	
				//Response.Write(str_update);
              
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





