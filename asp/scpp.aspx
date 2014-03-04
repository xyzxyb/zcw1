
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
    DataConn objConn=new DataConn();
            string yh_id = Session["yh_id"].ToString();
         

            //删除品牌
            {
                
                string ppid_str = Request["pp_id"]; 				//like ",214,238,237"
               string ppid_list = ppid_str.Substring(1);
               		
                string str_update = "delete from  品牌字典 where pp_id in ("+ ppid_list+")";
                    
              
                int ret = objConn.ExecuteSQLForCount(str_update,false);	
								//Response.Write(str_update);
        
            }	                    
		
     %>

    <body>
        <p>
        </p> 
         <p>
        </p>
       
        <a style="color: Red" onclick="clickMe()">恭喜您，删除品牌成功，请点击我返回。 </a>
        <script>
            function clickMe() {
                window.close();
                opener.location.reload();

            }
        </script>
        

    </body>





