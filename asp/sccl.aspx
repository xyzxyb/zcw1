<!--
        �����ղ�ҳ��
        �ļ�����sccl.ascx
        ���������cl_id   ����id
               
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
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/sccl2.aspx" charset="utf8"></script>

    <title>�ղز���</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<body>
    <div class="dlqq">
        <div class="dlqq1">
            <%
		
		HttpCookie QQ_id = Request.Cookies["QQ_id"];
        Object logout = Session["logout"];
        String  cl_id = Request["cl_id"];
		
		//Response.Write("QQ_id is " + QQ_id.Value + "<p>");
		
		if ((QQ_id == null ) || (QQ_id != null && logout!= null ))
		{
			 //Response.Write("openid is empty");
            %>
            <span class="dlzi">�𾴵Ĳɹ��̣�����! </span>
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
        else
        {
           //Response.Write("QQ_id is " + QQ_id.Value + "<p>");

            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);

            string yh_id="����";
            
            try{
                //��ѯ�Ƿ��QQid�Ѿ���¼��
                string str_checkuserexist = "select count(*) from �û��� where QQ_id = '"+QQ_id.Value+"'";
                SqlCommand cmd_checkuserexist = new SqlCommand(str_checkuserexist, conn);
       
                conn.Open();
                Object res_checkuserexist = cmd_checkuserexist.ExecuteScalar();
                if (res_checkuserexist != null) 
                {
                     int count = Convert.ToInt32(res_checkuserexist);
                     if (count ==0 )  //qq_id �����ڣ���Ҫ�����û���
                     {
        
                           String str_insertuser = "INSERT into �û��� (QQ_id) VALUES ('"+ QQ_id.Value+"')";
                           SqlCommand cmd_insertuser = new SqlCommand(str_insertuser, conn);         
                           cmd_insertuser.ExecuteNonQuery();

                           String str_updateyhid = "update �û��� set yh_id = (select myId from �û��� where QQ_id = '"+QQ_id.Value+"') where QQ_id = '"+QQ_id.Value+"'";
                           SqlCommand cmd_updateyhid = new SqlCommand(str_updateyhid, conn);         
                           cmd_updateyhid.ExecuteNonQuery();
                     }

                     //���yh_id��QQ_idӦ��Ϊ
                     String str_getyhid = "select myId from �û��� where QQ_id ='"+ QQ_id.Value+"'";
                     SqlCommand cmd_getyhid = new SqlCommand(str_getyhid, conn);
                     Object res_yhid = cmd_getyhid.ExecuteScalar();
                     if (res_yhid != null) 
                     {
                         yh_id = Convert.ToString(res_yhid);
                     }

                    
                  
                      //���жϡ��ɹ��̹�ע���ϱ��Ƿ��иü�¼�����û�У������
                      string str_checkexist = "select count(*) from �ɹ��̹�ע���ϱ� where yh_id = '"+yh_id+"' and cl_id ='"+cl_id+"'";
                      SqlCommand cmd_checkexist = new SqlCommand(str_checkexist, conn);
                      int res_checkexist = Convert.ToInt32(cmd_checkexist.ExecuteScalar());
                      if (res_checkexist !=1 ) 
                      {
                       
                          String str_getcl = "select ��ʾ��,���ϱ��� from ���ϱ� where cl_id ='"+cl_id+"'";
                          SqlDataAdapter da_cl = new SqlDataAdapter(str_getcl, conn);
                          DataSet ds_cl = new DataSet();
                          da_cl.Fill(ds_cl, "���ϱ�");            
                          DataTable dt_cl = ds_cl.Tables[0];
                          String str_clname = Convert.ToString(dt_cl.Rows[0]["��ʾ��"]);
                          String str_clcode = Convert.ToString(dt_cl.Rows[0]["���ϱ���"]);
                      
                          String str_addcl = "insert into �ɹ��̹�ע���ϱ� (yh_id,cl_id,��������,���ϱ���) values ('"+yh_id+"','"+cl_id+"','"+str_clname+"','"+str_clcode+"')";
                          SqlCommand cmd_addcl = new SqlCommand(str_addcl, conn); 
                          cmd_addcl.ExecuteNonQuery();
                       }
                     
                }
            }
            catch (Exception ex){
                Response.Write(ex);
            }
            finally{
                conn.Close();
            }           

           

			Response.Write("<span class='dlzi'>�𾴵Ĳɹ��̣�����!</span>");
            Response.Write("<span class='dlzi'>�ò����ѱ��ղسɹ���</span>");
            Response.Write("<span class='dlzi'><a href='cgsgl.aspx' target='_blank'>�����Ե���鿴���ղص�������Ϣ��</a></span>");
            Response.Write("<span class='dlzi' onclick='window.close()'>�رմ˴���</span>");

        }
    
            %>
        </div>
    </div>






</body>
</html>
