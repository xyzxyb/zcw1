<!--
      ���쳧��ҳ��
	  (���û����쳧�̺� �Ѷ�Ӧ���û�id��������Ĺ�Ӧ��(���Ϲ�Ӧ����Ϣ���yh_id))
	  �ļ���:  ���쳧��.aspx        
	  �������:��	  
     
--> 


<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server"  > 
		
		
               protected DataTable dt_wrl_gys = new DataTable(); //δ����Ĺ�Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��) 	
               protected DataTable dt_yrl_gys= new DataTable(); //�Ѿ�����Ĺ�Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��) 	
			   protected DataTable dt_dsh_gys = new DataTable(); //��ʾ�û�����Ĺ�Ӧ��

               protected void Page_Load(object sender, EventArgs e)
               {  
                    
			        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection conn = new SqlConnection(constr);
					string yh_id = Convert.ToString(Session["yh_id"]);
					
					string str_yh = "select ���� from �û��� where yh_id ='"+ yh_id+"' ";
                    SqlDataAdapter da_yh = new SqlDataAdapter(str_yh, conn);
                    DataSet ds_yh = new DataSet();
                    da_yh.Fill(ds_yh, "���Ϲ�Ӧ����Ϣ��");
                    DataTable dt_yh = ds_yh.Tables[0];
					string gys_type = Convert.ToString(dt_yh.Rows[0]["����"]);
					
					//�����û����������(������/������)��ѯ��صĹ�Ӧ��
                    string str_wrl_gys = "select ��Ӧ��,gys_id from ���Ϲ�Ӧ����Ϣ�� where ��λ����='"+gys_type+"' "
					+"and yh_id is null or ��λ����='"+gys_type+"' and yh_id='' ";
                    SqlDataAdapter da_wrl_gys = new SqlDataAdapter(str_wrl_gys, conn);
                    DataSet ds_wrl_gys = new DataSet();
                    da_wrl_gys.Fill(ds_wrl_gys, "���Ϲ�Ӧ����Ϣ��");
                    dt_wrl_gys = ds_wrl_gys.Tables[0];				                             
                    	                
               }
	           
                   
        
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
   <title>���쳧��ҳ��</title>
   <link href="css/css.css" rel="stylesheet" type="text/css" />
   <link href="css/all of.css" rel="stylesheet" type="text/css" />
    <script language ="javascript">
        function send_request() 
        {
            var gys_list = document.getElementById("gyslist");
            var gys_id = gys_list.options[gys_list.selectedIndex].value;
            //alert(gys_id);

            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    alert(xmlhttp.responseText);
                    location.reload();
                    //document.getElementById("rljg").innerHTML = xmlhttp.responseText;

                }
            }


            xmlhttp.open("GET", "rlcs2.aspx?gys_id=" +gys_id, true);
            xmlhttp.send();
        }
    </script>
</head>




<body>

<!-- ͷ��2��ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ��2����-->

<%                 

                    string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection conn = new SqlConnection(constr);
                    //��ѯ��Ӧ������� �������ͨ��,��ʾ������Ĺ�Ӧ��
					string yh_id = Convert.ToString(Session["yh_id"]);
					string str_select = "select count(*) from ��Ӧ����������� where yh_id = '"+yh_id +"'";
					conn.Open();
					SqlCommand cmd_select = new SqlCommand(str_select, conn);                           
					Object obj_checkexist_gysid = cmd_select.ExecuteScalar();
					conn.Close();
					
					string gys_spjg = "";
                    if (obj_checkexist_gysid != null) 
                    {
                        int count = Convert.ToInt32(obj_checkexist_gysid);
                        if (count !=0 )  //��Ӧ�������м�¼ ֱ�Ӳ�ѯ �Ƿ�����ͨ��
                        {        
                            
                            String gyssq_select = "select gys_id, ������� from ��Ӧ����������� where yh_id = '"+yh_id +"'";							
                            SqlDataAdapter da_gyssq = new SqlDataAdapter (gyssq_select,conn);
					        DataSet ds_gysxx = new DataSet();
					        da_gyssq.Fill(ds_gysxx,"��Ӧ�����������");					
					        DataTable dt_gysxx = ds_gysxx.Tables[0];
					        gys_spjg = Convert.ToString(dt_gysxx.Rows[0]["�������"]);
							string gys_id = Convert.ToString(dt_gysxx.Rows[0]["gys_id"]);
                            if(gys_spjg.Equals("ͨ��"))	
							{
							   //���²��Ϲ�Ӧ����Ϣ��
                               String str_updateuser = "update ���Ϲ�Ӧ����Ϣ�� set yh_id = '"+yh_id +"' where gys_id = '"+gys_id+"'";
							   conn.Open();
                               SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                               cmd_updateuser.ExecuteNonQuery();
							   conn.Close();
							
							   string str_yrl_gys = "select ��Ӧ��,gys_id,��ϵ��ַ from ���Ϲ�Ӧ����Ϣ�� where yh_id ='"+ yh_id+"'";
                               SqlDataAdapter da_yrl_gys = new SqlDataAdapter(str_yrl_gys, conn);
                               DataSet ds_yrl_gys = new DataSet();
                               da_yrl_gys.Fill(ds_yrl_gys, "���Ϲ�Ӧ����Ϣ��");
                               dt_yrl_gys = ds_yrl_gys.Tables[0];			   						                                                    
                    
							}
                            if(gys_spjg.Equals("��ͨ��"))	
							{
							   String str_updateuser = "update ���Ϲ�Ӧ����Ϣ�� set yh_id = '' where gys_id = '"+gys_id+"'";
							   conn.Open();
                               SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                               cmd_updateuser.ExecuteNonQuery();
							   
							   //��֤��ͨ��,ͬʱϣ���û��������쳧��,���԰�ԭ�еļ�¼�ӹ�Ӧ��������������
							   String str_delete = "delete ��Ӧ�����������  where gys_id = '"+gys_id+"'";							  
                               SqlCommand cmd_delete = new SqlCommand(str_delete, conn);         
                               cmd_delete.ExecuteNonQuery();
							   conn.Close();
							}
							if(gys_spjg.Equals("�����"))	
							{			  							
							   string dsh_gys = "select ��Ӧ��,gys_id,��ϵ��ַ from ��Ӧ����������� where yh_id ='"+ yh_id+"'";
                               SqlDataAdapter da_dsh_gys = new SqlDataAdapter(dsh_gys, conn);
                               DataSet dsh_yrl_gys = new DataSet();
                               da_dsh_gys.Fill(dsh_yrl_gys, "��Ӧ�����������");
                               dt_dsh_gys = dsh_yrl_gys.Tables[0];				                                                
                            }
                        }
					         
                    }
%>

<%
      if(gys_spjg!="")	
                  {				  
				  if(gys_spjg.Equals("ͨ��"))
				   {
	%>				
					   <div class="rlcs"><span class="rlcszi" style="color:Blue;font-size:12px">
				       <%Response.Write("��ϲ��!�����ͨ��,���Թ�������������Ϣ,���������Ϣ����ز���!!");%>
					   </span></div>     
			   
		<% }}%>
					
<%
  if(dt_yrl_gys.Rows.Count > 0)  //�Ѿ�������Ĺ�Ӧ����
  {
  %>
    <div class="rlcs"><span class="rlcszi" style="color:Blue;font-size:12px">���Ѿ��ڱ�վ����Ĺ�Ӧ������:</span></div>
    <%foreach (System.Data.DataRow row in dt_yrl_gys.Rows)
      { %>
        <span class="rlcszi"><a href="gysxx.aspx?gys_id=<%=row["gys_id"].ToString()%>"><%=row["��Ӧ��"].ToString() %></a></span>
		
    <%} %>
    <div class="rlcs1"></div>
  <%
  }
  
%>

<form id="form1" >
  <div class="rlcs"><span class="rlcszi">������������Ϣ�Ѿ��ڱ�վ���������̣� ��������ͼ</span><img src="images/www_03.jpg" /></div>
 
   
    
                  	
	<% 	   	      if(gys_spjg!="")	
                  {			    							     				  				    	
				    if(gys_spjg.Equals("��ͨ��"))
				    {
	    %>			  <div class="rlcs"><span class="rlcszi" style="color:Blue;font-size:12px">
				      <% Response.Write("�����������������Ϣ��׼ȷ!����������!"); %>
					   </span></div> 
	<%				   
				    }	
			        if(gys_spjg.Equals("�����"))
				    {
					%>
					<div class="rlcs"><span class="rlcszi" style="color:Blue;font-size:12px">
				      <% Response.Write("�𾴵��û�,����!�����ڱ�վ������");%>
					  <br>
					  <%  foreach (System.Data.DataRow row in dt_dsh_gys.Rows)
                    { %>                    
					<a  style="color:Blue;font-size:12px" href="gysxx.aspx?gys_id=<%=row["gys_id"]%>"><%=row["��Ӧ��"].ToString() %></a>				
		            
                    <%} %>
					</span></div>   
					
					
					
					   <div class="rlcs"><span class="rlcszi" style="color:Blue;font-size:12px">
                 	<%   Response.Write("�������������Ϣ���ύ,�����ĵȴ�,�ҷ�������Ա�ᾡ������ظ�."); %>			
					   </span></div>
				 <%   }
				  }
		        %>
               
 


  <br>
  <br>
  <div class="rlcs1">
  <div class="rlcs2"><input name="sou1" type="text" class="sou1" /><a href="#"><img src="images/ccc_03.jpg" /></a></div>
  <div class="rlcs3">


   <div class="rlcs4"> <span class="rlcs5">��ѯ���</span>
       <select name="gys" id="gyslist" onchange="Select_Gys_Name(this.options[this.options.selectedIndex].value)">
      <%                 
	       foreach (System.Data.DataRow row in dt_wrl_gys.Rows)
           { 	  
	  %>
        <span class="rlcs6"><option name="list" value="<%=row["gys_id"].ToString() %>" class="ck"/><%=row["��Ӧ��"].ToString() %></span>
      <%}%>
       </select>

   <a  onclick="send_request()" ></div> <img src="images/rl_03.jpg" /></a>
     
  </div>

   <div class="rlcs4">
    <span class="rlcs7">�����û���ҵ���˾���������ύ��˾���ϣ��ҷ�������Ա����3���������������˹���������ͼ���£�</span>
    <span><img src="images/www_03.jpg" /></span>
    </div>
  </div>


</form>


<div>
<!-- �������� ������ Ͷ�߽��� ��ʼ-->
<!-- #include file="static/aboutus.aspx" -->
<!-- �������� ������ Ͷ�߽��� ����-->
</div>

<!--  footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->






</body>
</html>
