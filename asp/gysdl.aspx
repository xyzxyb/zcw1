<!--
        ��Ӧ�̵�½ҳ��
        �ļ�����gysdl.ascx
        �����������
               
    -->
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/gysdl2.aspx" charset="utf8"></script>

    <title>��Ӧ�̵�½</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>
    
    </script>
    <div class="dlqq">
        <div class="dlqq1">
      <%
        
        HttpCookie QQ_id = Request.Cookies["QQ_id"];   
        Object logout = Session["logout"];  
        if (QQ_id != null && logout == null)
        {
            //Response.Write("openid is " + openId.Value + "<p>");

            //insert into db to store openid and its cl_id
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            
            try
            {
                
                String str_checkuserexist = "select count(*) from �û��� where QQ_id = '"+QQ_id.Value+"'";
                SqlCommand cmd_checkuserexist = new SqlCommand(str_checkuserexist, conn);
       
                conn.Open();
                Object obj_checkuserexist = cmd_checkuserexist.ExecuteScalar();
                if (obj_checkuserexist != null) 
                {
                     int count = Convert.ToInt32(obj_checkuserexist);
                     if (count ==0 )  //qq_id �����ڣ���Ҫ�����û���
                     {
        
                           String str_insertuser = "insert into �û��� (QQ_id) VALUES ('"+ QQ_id.Value+"')";
                           SqlCommand cmd_insertuser = new SqlCommand(str_insertuser, conn);         
                           cmd_insertuser.ExecuteNonQuery();
                           String str_updateuser = "update �û��� set ע��ʱ��=(select getdate()),"
						   +"yh_id = (select myId from �û��� where QQ_id = '"+QQ_id.Value+"') "
 						   +"where QQ_id = '"+QQ_id.Value+"'";
                           SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                           cmd_updateuser.ExecuteNonQuery();                                   
                      }
                                    
                }
				//ȷ��QQ_id��Ϊ�� �����ӵĹ�Ӧ����ҳ��
			   string str_select = "select QQ_id from �û��� where QQ_id = '"+QQ_id.Value+"'";
               SqlDataAdapter da_select = new SqlDataAdapter(str_select,conn);
               DataSet ds_ = new DataSet();
			   DataTable dt_ = new DataTable();
               da_select.Fill(ds_, "�û���");           
               dt_ = ds_.Tables[0];
               string passed_ = Convert.ToString(dt_.Rows[0]["QQ_id"]);
               if(passed_!="")
               {			   
                 Response.Redirect("gyszym.aspx");  
               }
            	
            }
            catch (Exception ex){
                throw(ex);
            }
            finally{
                conn.Close();
            }           
        }
        else
        {
            //Response.Write("openid is empty");
            %>
            <span class="dlzi">�𾴵Ĺ�Ӧ�̣�����! </span>
            <span class="dlzi">�����ұ߰�ť��½��</span>
            <span class="dlzi2" id="qqLoginBtn"></span>
            <script type="text/javascript">
                QC.Login({
                    btnId: "qqLoginBtn" //���밴ť�Ľڵ�id  

                });

            </script>
            <img src="images/wz_03.jpg">
            <%
        }
   
            %>
            
        </div>
    </div>






</body>
</html>
