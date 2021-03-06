<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sccl.aspx.cs" Inherits="asp_sccl" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        data-appid="1101078572" data-redirecturi="http://zhcnet.cn/asp/sccl2.aspx" charset="utf8"></script>

    <title>收藏材料</title>
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
            <span class="dlzi">尊敬的采购商，您好! </span>
            <span class="dlzi">请点击右边按钮登陆！</span>
            <span class="dlzi2" id="qqLoginBtn"></span>
            <script type="text/javascript">
                QC.Login({
                    btnId: "qqLoginBtn" //插入按钮的节点id  
                    
                });           
            </script>
            <img src="images/wz_03.jpg">
            <%
            
               
        }
        else
        {
           //Response.Write("QQ_id is " + QQ_id.Value + "<p>");

            string yh_id="错误";
            
            try{
                //查询是否该QQid已经登录过
                    DataConn objConn= new DataConn();
                string str_checkuserexist = "select count(*) from 用户表 where QQ_id = '"+QQ_id.Value+"'";
               
                Object res_checkuserexist = objConn.DBLook(str_checkuserexist);
                if (res_checkuserexist != null) 
                {
                     int count = Convert.ToInt32(res_checkuserexist);
                     if (count ==0 )  //qq_id 不存在，需要增加用户表
                     {
        
                           string str_insertuser = "INSERT into 用户表 (QQ_id) VALUES ('"+ QQ_id.Value+"')";
                            objConn.ExecuteSQL(str_insertuser,false);

                           string str_updateyhid = "update 用户表 set yh_id = (select myId from 用户表 where QQ_id = '"+QQ_id.Value+"') where QQ_id = '"+QQ_id.Value+"'";
                             objConn.ExecuteSQL(str_updateyhid,false);
                     }

                     //获得yh_id，QQ_id应该为
                    string str_getyhid = "select myId from 用户表 where QQ_id ='"+ QQ_id.Value+"'";
                  
                     Object res_yhid = objConn.DBLook(str_getyhid);
                     if (res_yhid != null) 
                     {
                         yh_id = Convert.ToString(res_yhid);
                     }

                    
                  
                      //先判断“采购商关注材料表”是否有该记录，如果没有，则插入
                      string str_checkexist = "select count(*) from 采购商关注材料表 where yh_id = '"+yh_id+"' and cl_id ='"+cl_id+"'";
                     
                      int res_checkexist = Convert.ToInt32(objConn.DBLook(str_checkexist));
                      if (res_checkexist !=1 ) 
                      {
                       
                          string str_getcl = "select 显示名,材料编码 from 材料表 where cl_id ='"+cl_id+"'";
                         
                          DataTable dt_cl = objConn.GetDataTable(str_getcl);
                          string str_clname = Convert.ToString(dt_cl.Rows[0]["显示名"]);
                          string str_clcode = Convert.ToString(dt_cl.Rows[0]["材料编码"]);
                      
                          string str_addcl = "insert into 采购商关注材料表 (yh_id,cl_id,材料名称,材料编码) values ('"+yh_id+"','"+cl_id+"','"+str_clname+"','"+str_clcode+"')";
                                    objConn.ExecuteSQL(str_addcl,false);
                       }
                     
                }
            }
            catch (Exception ex){
                Response.Write(ex);
            }
          

			Response.Write("<span class='dlzi'>尊敬的采购商，您好!</span>");
            Response.Write("<span class='dlzi'>该材料已被收藏成功！</span>");
            Response.Write("<span class='dlzi'><a href='cgsgl.aspx' target='_blank'>您可以点击查看已收藏的所有信息。</a></span>");
            Response.Write("<span class='dlzi' onclick='window.close()'>关闭此窗口</span>");

        }
    
            %>
        </div>
    </div>

</body>
</html>