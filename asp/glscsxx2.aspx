<!--  
	    ������������Ϣҳ��   ����������Ϣ�����޸ı���
        �ļ�����glscsxx2.aspx
        ���������gys_id    
-->


<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��������Ϣҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
    
</head>

<script runat="server"  >

             
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
			conn.Open();
			
			string gys_id = Request["gys_id"];                  //��ȡ�Ĺ�Ӧ��id
			String yh_id = Convert.ToString(Session["yh_id"]);   //��ȡ�û�id
			
                string companyname = Request["companyname"];   //��˾����
                string address = Request["address"];            //��ַ
                string tel = Request.Form["tel"];               //�绰
                string homepage = Request.Form["homepage"];     //��ҳ
                string fax = Request["fax"];                    //����  
				string area = Request["area"];                  //����
                string description = Request.Form["description"];  //��˾���
                string name = Request.Form["name"];                //��ϵ��
                string phone = Request.Form["phone"];              //��ϵ���ֻ�
				string Business_Scope = Request.Form["Business_Scope"];   //��Ӫ��Χ
				
				if(gys_id!="")
				{
				  string sql_gys_id = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gys_id+"' ";
				  SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);
                  
                  Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();

                  if (obj_check_gys_exist != null)
                  {
                    int count = Convert.ToInt32(obj_check_gys_exist);
                    if (count == 0)  
                    {
                       string str_insert = "insert into ��Ӧ���Լ��޸Ĵ���˱� (gys_id)values('"+gys_id+"')";
				       
				       SqlCommand cmd_insert = new SqlCommand(str_insert,conn);
				       cmd_insert.ExecuteNonQuery();			 		                          
                    }										 
				
                    string str_update = "update ��Ӧ���Լ��޸Ĵ���˱� set ��˾����='"+companyname+"',��˾��ַ='"+address+"',"
				    +"��˾�绰='"+tel+"',��˾��ҳ='"+homepage+"',��˾����='"+area+"',��˾����='"+fax+"',�Ƿ�����='1',"
				    +"��ϵ������='"+name+"',��ϵ�˵绰='"+phone+"',��λ����='������',��Ӫ��Χ='"+Business_Scope+"',"
				    +"�������='�����',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id='"+gys_id+"' ";
				    SqlCommand cmd_update = new SqlCommand(str_update,conn);
				    cmd_update.ExecuteNonQuery(); 
                  }		 				  			  
				}
				else
				{
				   //����û�"û��"���glscsxx.aspx ������ ���޸ķ�������Ϣ,��ô��ִ�����´���,�����޸�
				   //�����û�id ��ѯ������ �п����Ƿ�����,�п�����������
				   
            
			       string str_gys_id = "select ��λ����, gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='"+yh_id+"' " ;//��ѯ��Ӧ��id	141	
                   SqlDataAdapter da_gys_id = new SqlDataAdapter(str_gys_id, conn);
			       DataSet ds_gys_id = new DataSet();
                   da_gys_id.Fill(ds_gys_id, "���Ϲ�Ӧ����Ϣ��");
                   DataTable dt_gys_id = ds_gys_id.Tables[0];
			       string str_gysid = Convert.ToString(dt_gys_id.Rows[0]["gys_id"]);   //��ȡ��Ӧ��id  141
				   string str_gys_type = Convert.ToString(dt_gys_id.Rows[0]["��λ����"]);   
				   if(str_gys_type.Equals("������"))
				   {
				      
			      
				       String str_gysxxs_first = "select pp_id from  ���Ϲ�Ӧ����Ϣ�ӱ� where gys_id='"+str_gysid+"' ";   //183
				
                       SqlDataAdapter da_gysxxs_first = new SqlDataAdapter(str_gysxxs_first, conn);
			           DataSet ds_gysxxs_first = new DataSet();
                       da_gysxxs_first.Fill(ds_gysxxs_first, "���Ϲ�Ӧ����Ϣ�ӱ�");
                       DataTable dt_gysxxs_first = ds_gysxxs_first.Tables[0];
               	       string gys_pp_id = Convert.ToString(dt_gysxxs_first.Rows[0]["pp_id"]);	 //183	

              
                			
				
                       String str_frist = "select gys_id "
				       +"from ���Ϲ�Ӧ����Ϣ�� where  gys_id in (select scs_id from Ʒ���ֵ� where pp_id='"+gys_pp_id+"')"    //pp_id=183
				       +"and ��λ����='������'";
                        SqlDataAdapter da_frist = new SqlDataAdapter(str_frist, conn);
			           DataSet ds_frist = new DataSet();
                       da_frist.Fill(ds_frist, "���Ϲ�Ӧ����Ϣ��");
                       DataTable dt_frist = ds_frist.Tables[0];
				       string gysid_frist = Convert.ToString(dt_frist.Rows[0]["gys_id"]);   //��ȡĬ�ϵ�������id  125
				       string sql_gys_id = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid_frist+"' ";
				     
				       SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);                  
                       Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();              				
                   
                       if (obj_check_gys_exist != null)
                       {				     
                           int count = Convert.ToInt32(obj_check_gys_exist);
                           if (count == 0)  
                           {                     				                          
						       string str_insert = "insert into ��Ӧ���Լ��޸Ĵ���˱� (gys_id)values('"+gysid_frist+"')";
				       
				               SqlCommand cmd_insert = new SqlCommand(str_insert,conn);
				               cmd_insert.ExecuteNonQuery();
				           }
				           string str_update = "update ��Ӧ���Լ��޸Ĵ���˱� set ��˾����='"+companyname+"',��˾��ַ='"+address+"',"
				           +"��˾�绰='"+tel+"',��˾��ҳ='"+homepage+"',��˾����='"+area+"',��˾����='"+fax+"',�Ƿ�����='1',"
				           +"��ϵ������='"+name+"',��ϵ�˵绰='"+phone+"',��λ����='������',��Ӫ��Χ='"+Business_Scope+"',"
				           +"�������='�����',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id='"+gysid_frist+"'";						   
					  
				           SqlCommand cmd_update = new SqlCommand(str_update,conn);
				           cmd_update.ExecuteNonQuery();                                        
                       }			 				    
				   }
				   
			       if(str_gys_type.Equals("������"))
				   {
			          //string str_pp_id = "select pp_id from Ʒ���ֵ� where scs_id='"+str_gysid+"' "; //��ѯƷ��id		
                      //SqlDataAdapter da_pp_id = new SqlDataAdapter(str_pp_id, conn);
			          //DataSet ds_pp_id = new DataSet();
                      //da_pp_id.Fill(ds_pp_id, "Ʒ���ֵ�");
                      //DataTable dt_pp_id = ds_pp_id.Tables[0];
			          //string str_ppid = Convert.ToString(dt_pp_id.Rows[0]["pp_id"]);   //��ȡƷ��id  185		   				 
				   
				      //string sql_gys_id = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id in "
				      //+"(select top 1 fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='"+str_ppid+"')"; //�м���������,���м���fxs_id,ȡ��һ��  139
				      //SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);                  
                      //Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();
					  
					   string sql_gys_id = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id ='"+str_gysid+"' ";				     
				       SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);                  
                       Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();
                   
                       if (obj_check_gys_exist != null)
                       {
				     
                        int count = Convert.ToInt32(obj_check_gys_exist);
                        if (count == 0)  
                        {                        					 
                           //string str_insert = "insert into ��Ӧ���Լ��޸Ĵ���˱� (gys_id)select top 1 fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� "
						   //+"where pp_id='"+str_ppid+"'";				       
				           //SqlCommand cmd_insert = new SqlCommand(str_insert,conn);
				          // cmd_insert.ExecuteNonQuery();
						   
						   string str_insert = "insert into ��Ӧ���Լ��޸Ĵ���˱� (gys_id)values('"+str_gysid+"')";
				       
				           SqlCommand cmd_insert = new SqlCommand(str_insert,conn);
				           cmd_insert.ExecuteNonQuery();
				        }
				        //string str_update = "update ��Ӧ���Լ��޸Ĵ���˱� set ��˾����='"+companyname+"',��˾��ַ='"+address+"',"
				        //+"��˾�绰='"+tel+"',��˾��ҳ='"+homepage+"',��˾����='"+area+"',��˾����='"+fax+"',�Ƿ�����='1',"
				        //+"��ϵ������='"+name+"',��ϵ�˵绰='"+phone+"',��λ����='������',��Ӫ��Χ='"+Business_Scope+"',"
				        //+"�������='�����',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id in"
						//+"(select top 1 fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='"+str_ppid+"')";					  
				        //SqlCommand cmd_update = new SqlCommand(str_update,conn);
				        //cmd_update.ExecuteNonQuery();  

						string str_update = "update ��Ӧ���Լ��޸Ĵ���˱� set ��˾����='"+companyname+"',��˾��ַ='"+address+"',"
				        +"��˾�绰='"+tel+"',��˾��ҳ='"+homepage+"',��˾����='"+area+"',��˾����='"+fax+"',�Ƿ�����='1',"
				        +"��ϵ������='"+name+"',��ϵ�˵绰='"+phone+"',��λ����='������',��Ӫ��Χ='"+Business_Scope+"',"
				        +"�������='�����',updatetime=(select getdate()),yh_id='"+yh_id+"' where gys_id = '"+str_gysid+"'";					  
				        SqlCommand cmd_update = new SqlCommand(str_update,conn);
				        cmd_update.ExecuteNonQuery();
                      }			 				  
				   }
				}
				
                
				conn.Close();	
                //Response.Write("����ɹ�");
                //Response.Redirect("glscsxx.aspx");
        }
</script>
<body>
<%string gys_id = Request["gys_id"];                  //��ȡ�Ĺ�Ӧ��id%>
<a style="color: Red"  onclick=window.location.href="glscsxx.aspx?scsid=<%=gys_id%>">�����µ���Ϣ���ύ,�ȴ����,�뷵��! </a>
</body>
</html>













