<!--
        �ղع�Ӧ��ҳ��
        �ļ�����scgyc.ascx
        ���������gys_id ��Ӧ��id
               
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
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/scgys2.aspx" charset="utf8"></script>

    <title>�ղع�Ӧ��</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>


<body>
    <div class="dlqq">
        <div class="dlqq1">
            <%
   
        HttpCookie QQ_id = Request.Cookies["QQ_id"];
        Object logout = Session["logout"];
        String  gys_id = Request["gys_id"];
		
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
        
        } else
        {
            //Response.Write("QQ_id is " + QQ_id.Value + "<p>");

           DataConn conn= new DataConn();
            string yh_id="����";
            
            try{
                //��ѯ�Ƿ��QQid�Ѿ���¼��
                string str_checkuserexist = "select count(*) from �û��� where QQ_id = '"+QQ_id.Value+"'";
                
                Object res_checkuserexist =conn.DBLook(str_checkuserexist);
                if (res_checkuserexist != null) 
                {
                     int count = Convert.ToInt32(res_checkuserexist);
                     if (count ==0 )  //qq_id �����ڣ���Ҫ�����û���
                     {
                           string str_insertuser = "INSERT into �û��� (QQ_id) VALUES ('"+ QQ_id.Value+"')";
                            conn.ExecuteSQL(str_insertuser,false);

                           string str_updateyhid = "update �û��� set yh_id = (select myId from �û��� where QQ_id = '"+QQ_id.Value+"') where QQ_id = '"+QQ_id.Value+"')";
                         conn.ExecuteSQL(str_updateyhid,false);
                     }

                     //���yh_id
                     string str_getyhid = "select myId from �û��� where QQ_id ='"+ QQ_id.Value+"'";
                   
                     Object res_yhid = conn.DBLook(str_getyhid);
                     if (res_yhid != null) 
                     {
                         yh_id = Convert.ToString(res_yhid);
                     }

                    
                  
                      //���жϡ��ɹ��̹�ע��Ӧ�̱��Ƿ��иü�¼�����û�У������

                      string str_checkexist = "select count(*) from �ɹ��̹�ע��Ӧ�̱� where yh_id = '"+yh_id+"' and gys_id ='"+gys_id+"'";
                   
                      int res_checkexist = Convert.ToInt32(conn.DBLook(str_checkexist));
                      if (res_checkexist !=1 ) 
                      {
       
                      //
                          string str_getcl = "select ��Ӧ��,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id ='"+gys_id+"'";
                            
                          DataTable dt_cl = conn.GetDataTable(str_getcl);
                          string str_gysid = Convert.ToString(dt_cl.Rows[0]["gys_id"]);
                          string str_gysname = Convert.ToString(dt_cl.Rows[0]["��Ӧ��"]);


                          string str_addgys = "insert into �ɹ��̹�ע��Ӧ�̱� (yh_id,gys_id,��Ӧ������) values ('"+yh_id+"','"+str_gysid+"','"+str_gysname+"')";
                                    conn.ExecuteSQL(str_addgys,false);
                      }

                      
                }
            }
            catch (Exception ex){
                Response.Write(ex);
            }
              

			Response.Write("<span class='dlzi'>�𾴵Ĳɹ��̣�����!</span>");
            Response.Write("<span class='dlzi'>�ù�Ӧ����Ϣ�ѱ��ղسɹ���</span>");
            Response.Write("<span class='dlzi'><a href='cgsgl_2.aspx' target='_blank'>�����Ե���鿴���ղص�������Ϣ��</a></span>");
            Response.Write("<span class='dlzi' onclick='window.close()'>�رմ˴���</span>");


        
        }
    
            %>
        </div>
    </div>






</body>
</html>
