
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
           
            string yh_id = Session["yh_id"].ToString();
         

            //��������Ʒ��д�����ݿ�            {
              
                string fxs_id = Request["fxs_id"]; 		
                string pp_id = Request["pp_id"];		
                string pp_name = Request["pp_name"];
   
    		 DataConn conn3=new DataConn();
                string str_insert = " insert into  �����̺�Ʒ�ƶ�Ӧ��ϵ�� (pp_id, Ʒ������, �Ƿ�����,fxs_id,yh_id) values('"+ pp_id + "','"+pp_name+"', 1,'"+fxs_id+"','" +yh_id+"' ) ";
            
                //Response.Write(str_insert);
    conn3.ExecuteSQL(str_insert,true);
            }	                    
		
     %>

    <body>
        <p>
        </p> 
         <p>
        </p>
       
        <a style="color: Red" onclick="clickMe()">��ϲ������������Ʒ�Ƴɹ��������ҷ��ء�</a>
        <script>
            function clickMe() {
                window.close();
                opener.location.reload();

            }
        </script>
        

    </body>





