<!--
        ��Ӧ�̲�����Ϣҳ2  (δ��)
        �ļ���:  gysbuxx.aspx   
        
-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript">


    </script>
</head>
<body>


    <script runat="server">                 
        
		
        protected void Page_Load(object sender, EventArgs e)
        { 
             string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
             SqlConnection conn = new SqlConnection(constr);
			 String yh_id = Convert.ToString(Session["yh_id"]); 	 //��ȡ�����û�id	 
             //string yh_id = "26";
			 
             string gys_name = Request["gys_name"];                  //��˾����
             string gys_address = Request["gys_address"];            //��ַ
             string gys_homepage = Request.Form["gys_homepage"];     //��˾��ҳ
             string gys_phone = Request.Form["gys_phone"];           //��˾�绰
             string user_name = Request["user_name"];                //��������  
             string user_phone = Request["user_phone"];              //�����ֻ�			 
             string user_qq = Request.Form["user_qq"];               //����QQ����
			 string scs_type = Request.Form["scs_type"];             //��Ӧ������
			 
			 
			 if(gys_name!="")
			 {             		              			  
			  string passed_gys;	  				  
              SqlDataAdapter da_gyssq = new SqlDataAdapter("select �Ƿ���֤ͨ�� from �û��� where yh_id='"+yh_id+"' ", conn);
              DataSet ds_gyssq = new DataSet();
			  DataTable dt_gyssq = new DataTable();
              da_gyssq.Fill(ds_gyssq, "�û���");           
              dt_gyssq = ds_gyssq.Tables[0];
              passed_gys = Convert.ToString(dt_gyssq.Rows[0]["�Ƿ���֤ͨ��"]);                              	
	          if(passed_gys.Equals("ͨ��"))   //����û���ƽ̨��֤ͨ���� �ټ���������� �����޸��û���Ϣ ֱ�ӷ���
			  {
				       return;
		      }
		
			  //�����û���			  
			  string sql_yhxx = "update  �û��� set updatetime=(select getdate()), ��˾����='"+gys_name+"',��˾��ַ='"+gys_address+"',"
			  +"��˾��ҳ='"+gys_homepage+"',��˾�绰='"+gys_phone+"',����='"+user_name+"',�ֻ�='"+user_phone+"', "
			  +"QQ����='"+user_qq+"',����='"+scs_type+"',�Ƿ���֤ͨ��='�����',�ȼ�='��ͨ�û�' where yh_id='"+yh_id+"' ";
			  conn.Open();
			  SqlCommand cmd_gysbtxx = new SqlCommand(sql_yhxx,conn);
			  int ret = (int)cmd_gysbtxx.ExecuteNonQuery();
				   
       
              conn.Close();	                                       
             }  
		    
		    //Response.Write("�����ĵȴ�,�ҷ�������Ա�ᾡ������ظ�!");
            //Response.Redirect("gyszym.aspx");			
        }

    </script>
    

   
</body>
<a style="color: Red"  onclick=window.location.href="gyszym.aspx">��Ϣ�ѱ���ɹ�,�ȴ����,�뷵��! </a>

</html>