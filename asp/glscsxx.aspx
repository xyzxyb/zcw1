<!--      
	   ������������Ϣ �޸ı�������������Ϣ ɾ��ѡ��Ʒ�� �����µ�Ʒ��
       �ļ�����glscsxx.aspx 
       �����������    
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>������������Ϣ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script type="text/javascript" language="javascript">

        function Update_scs(id) {          
            
            if (window.XMLHttpRequest) {
                xmlhttp = new XMLHttpRequest();
            }
            else {
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				
                var array = new Array();           //��������
		 		array = xmlhttp.responseText;     //�����滻���ص�json�ַ���
				
		        var json = array;
                var myobj=eval(json);              //�����ص�JSON�ַ���ת��JavaScript���� 			
				
				
                for(var i=0;i<myobj.length;i++){  //����,��ajax���ص�������䵽�ı�����				
			     
				 document.getElementById('companyname').value = myobj[i].gys_name;       //��Ӧ��
				 document.getElementById('address').value = myobj[i].gys_address;        //��ַ
				 document.getElementById('tel').value = myobj[i].gys_tel;                //�绰  			 
				 document.getElementById('homepage').value = myobj[i].gys_homepage;       //��ҳ
                 document.getElementById('fax').value = myobj[i].gys_fax;                 //����
				 document.getElementById('area').value = myobj[i].gys_area;               //��������
				 document.getElementById('name').value = myobj[i].gys_user;               //��ϵ��
				 document.getElementById('phone').value = myobj[i].gys_user_phone;          //��ϵ�˵绰
				 document.getElementById('gys_id').value = myobj[i].gys_id;           //ajax���صĹ�Ӧ��id	������ύʱʹ��	  				              
				
                }  
                   
                }
            }
            xmlhttp.open("GET", "glscsxx3.aspx?id=" + id, true);
            xmlhttp.send();
        }


</script>


<script runat="server">

        public List<GYS_Objects> Items1 { get; set; }
		public class GYS_Object
        { //����
           public string Sid { get; set; }    //�治ͬ��pp_id        		
        }
        public class GYS_Objects
        { //����
            public string Gys_sid { get; set; }
            public string Gys_name { get; set; }
        }
	   
        protected DataTable dt_gysxx = new DataTable();  //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
        protected DataTable dt_ppxx = new DataTable();   //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
        protected String gys_id;

        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            
            String yh_id = Convert.ToString(Session["yh_id"]);         
			//���쳧�̳ɹ�,�����û�id ��ѯ����Ĺ�Ӧ����Ϣ
			
			String str_type = "select ��λ���� ,gys_id from  ���Ϲ�Ӧ����Ϣ�� where yh_id='"+yh_id+"' ";  //��ѯ��λ����
			SqlDataAdapter da_type = new SqlDataAdapter(str_type, conn);
			DataSet ds_type = new DataSet();
            da_type.Fill(ds_type, "���Ϲ�Ӧ����Ϣ��");
            DataTable dt_type = ds_type.Tables[0];
			string gys_type = Convert.ToString(dt_type.Rows[0]["��λ����"]);
			string gys_type_id = Convert.ToString(dt_type.Rows[0]["gys_id"]);  //��Ӧ��id   141
			if (gys_type.Equals("������"))
			{
			 //����Ƿ�������Ϣ ֱ�Ӹ���yh_id ��ѯ��Ӧ����Ϣ 
             String str_gysxx = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  yh_id='"+yh_id+"' ";
             SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			 DataSet ds_gysxx = new DataSet();
             da_gysxx.Fill(ds_gysxx, "���Ϲ�Ӧ����Ϣ��");
             dt_gysxx = ds_gysxx.Tables[0];
           	}
            if (gys_type.Equals("������"))
			{	             
				//���ݷ�����id ��<���Ϲ�Ӧ����Ϣ�ӱ�>�� ��ȡ����ͬƷ�Ƶ�Ʒ��id  �ٸ���Ʒ��id��<Ʒ���ֵ�>��ѯ��ͬ�� ������id
				//�ٸ��ݲ�ͬ��������id ��ѯ��ͬ����������Ϣ
				
				String str_gysxxs = "select pp_id from  ���Ϲ�Ӧ����Ϣ�ӱ� where gys_id='"+gys_type_id+"' ";   //183,186
				
                SqlDataAdapter da_gysxxs = new SqlDataAdapter(str_gysxxs, conn);
			    DataSet ds_gysxxs = new DataSet();
                da_gysxxs.Fill(ds_gysxxs, "���Ϲ�Ӧ����Ϣ�ӱ�");
                DataTable dt_gysxxs = ds_gysxxs.Tables[0];
               	string gys_pp_id = Convert.ToString(dt_gysxxs.Rows[0]["pp_id"]);		

                this.Items1 = new List<GYS_Objects>();
                for(int x=0;x<dt_gysxxs.Rows.Count;x++)
                {
                   DataRow dr2 = dt_gysxxs.Rows[x];                                 		     
 			       GYS_Object item = new GYS_Object();                
                   item.Sid = Convert.ToString(dr2["pp_id"]);    //����ͬ��pp_id���뼯��
                   string sid = item.Sid;
				   //���ݲ�ͬ��pp_id ��ѯ ������,scs_id
                   String str_gys_name = "select ������,scs_id from Ʒ���ֵ� where  pp_id='"+sid+"' ";
                   SqlDataAdapter da_gys_name = new SqlDataAdapter(str_gys_name, conn);
			       DataSet ds_gys_name = new DataSet();			  
                   da_gys_name.Fill(ds_gys_name, "Ʒ���ֵ�");
                   DataTable dt = ds_gys_name.Tables[0];
                
               
                   GYS_Objects ite = new GYS_Objects();
                   ite.Gys_name = Convert.ToString(dt.Rows[0]["������"]);  //ÿѭ��һ�� ��ѭ���ķ����̴��뼯��
                   ite.Gys_sid = Convert.ToString(dt.Rows[0]["scs_id"]);
                   this.Items1.Add(ite); 
			    }				
				
                String str_gysxx = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id "
				+"from ���Ϲ�Ӧ����Ϣ�� where  gys_id in (select scs_id from Ʒ���ֵ� where pp_id='"+gys_pp_id+"')"    //pp_id=186
				+"and ��λ����='������'";
                SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			    DataSet ds_gysxx = new DataSet();
                da_gysxx.Fill(ds_gysxx, "���Ϲ�Ӧ����Ϣ��");
                dt_gysxx = ds_gysxx.Tables[0];

                				
				
            }
            if (dt_gysxx.Rows.Count == 0) Response.Redirect("gyszym.aspx");
			    
		

            
            gys_id = dt_gysxx.Rows[0]["gys_id"].ToString();
							
			SqlDataAdapter da_ppxx = new SqlDataAdapter("select Ʒ������,pp_id from Ʒ���ֵ� where �Ƿ�����='1' and scs_id='"+gys_id+"' ", conn);
            DataSet ds_ppxx = new DataSet();
            da_ppxx.Fill(ds_ppxx, "Ʒ���ֵ�");
            dt_ppxx = ds_ppxx.Tables[0];  			                                        
        }

       		
	
</script>

<body>

    <!-- ͷ����ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ������-->


    <form id="update_scs" name="update_scs" action="glscsxx2.aspx" method="post">
        <div class="fxsxx">
		   <span class="fxsxx1">
		   <%
			string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            String yh_id = Convert.ToString(Session["yh_id"]);         
			
            String str_gysxx_type = "select ��λ����, gys_id from ���Ϲ�Ӧ����Ϣ�� where  yh_id='"+yh_id+"' ";
            SqlDataAdapter da_gysxx_type = new SqlDataAdapter(str_gysxx_type, conn);
			DataSet ds_gysxx_type = new DataSet();
            da_gysxx_type.Fill(ds_gysxx_type, "���Ϲ�Ӧ����Ϣ��");
            DataTable dt_gysxxs = ds_gysxx_type.Tables[0];
            string gysid = Convert.ToString(dt_gysxxs.Rows[0]["gys_id"]);	  //141 �����û�id ��ȡ������id
			string gys_types = Convert.ToString(dt_gysxxs.Rows[0]["��λ����"]);
			
			
			
			//���ݷ�����id �Ӳ��Ϲ�Ӧ����Ϣ�ӱ��� ��ȡ����ͬƷ�Ƶ�Ʒ��id
			string sp_result="";
			
		    string id = Request["scsid"];    //��ȡglscsxx2ҳ�淵�ص�������id
			if(id!=null&id!="")
			{			  
			  Session["scsid"] = id;
			}
		    if (Session["scsid"] == null) 
		    {
		  
			
		    if(id==""||id==null)
		    {		  
		       if (gys_types.Equals("������"))
			   { 
			    string sql_gys_id = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid+"' ";   //127
		        SqlCommand cmd_checkuserexists = new SqlCommand(sql_gys_id, conn);            
                Object obj_check_gys_exist = cmd_checkuserexists.ExecuteScalar();
				if (obj_check_gys_exist != null)
                {
                 int count = Convert.ToInt32(obj_check_gys_exist);
                 if (count != 0)  
                 {  //��� ��Ӧ���Լ��޸Ĵ���˱� �м�¼ ��ѯ�������
			        string str_select = "select ������� from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid+"'";
			        SqlDataAdapter da_select = new SqlDataAdapter (str_select,conn);
			        DataSet ds_select = new DataSet();
			        da_select.Fill(ds_select,"��Ӧ���Լ��޸Ĵ���˱�");
			        DataTable dt_select = ds_select.Tables[0];
			        sp_result = Convert.ToString(dt_select.Rows[0]["�������"]); 
			        if(sp_result!="")
			        {
                      if (sp_result.Equals("ͨ��"))
                      {  
				  
				        //�������ͨ�� ˵���޸ĵĹ�Ӧ����Ϣ��Ч �� ��Ӧ���Լ��޸Ĵ���˱� ��Ч���ݸ��µ����Ϲ�Ӧ����Ϣ��
                        string sql = "update  ���Ϲ�Ӧ����Ϣ�� set ��Ӧ��=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),"
				        +"��ַ=(select ��˾��ַ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),�绰=(select ��˾�绰 from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),"
					    +"��ҳ=(select ��˾��ҳ from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid+"'),����=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),"
				        +"��ϵ��=(select ��ϵ������ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),��ϵ���ֻ�=(select ��ϵ�˵绰 from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid+"'),"
					    +"��������=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid+"'),"
					    +"��Ӫ��Χ=(select ��Ӫ��Χ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"') where gys_id ='"+gysid+"'";
                     
                        SqlCommand cmd2 = new SqlCommand(sql, conn);
                        int ret = (int)cmd2.ExecuteNonQuery();
					 
					    String str_gysxx = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+gysid+"' ";
                        SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			            DataSet ds_gysxx = new DataSet();
                        da_gysxx.Fill(ds_gysxx, "���Ϲ�Ӧ����Ϣ��");
                        dt_gysxx = ds_gysxx.Tables[0];					 
				     
					    Response.Write("��ϲ��!!!���޸ĵ������Ѿ�����,����!");
                      }
			         if (sp_result.Equals("��ͨ��"))
                     {
                        string sql_delete = "delete  ��Ӧ���Լ��޸Ĵ���˱� where gys_id ='"+gysid+"' ";			                    
                        SqlCommand cmd_delete = new SqlCommand(sql_delete, conn);
                        int ret = (int)cmd_delete.ExecuteNonQuery();
			         
					    Response.Write("���ύ�޸ĵ����ݲ�����,��������д�����ύ!");
                     }
				    if (sp_result.Equals("�����"))
                    {
                        String str_gysxx = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,��˾����,��˾����,��ϵ������,��ϵ�˵绰,"
					    +"��Ӫ��Χ,gys_id  from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"' ";
                        SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			            DataSet ds_gysxx = new DataSet();
                        da_gysxx.Fill(ds_gysxx, "��Ӧ���Լ��޸Ĵ���˱�");
                        dt_gysxx = ds_gysxx.Tables[0];
			         
					    Response.Write("��˵���!");
                    }
			      }
                }
			   }
			  }
			 if (gys_types.Equals("������"))
			 { 
			    String str_gysxxs_first = "select pp_id from  ���Ϲ�Ӧ����Ϣ�ӱ� where gys_id='"+gysid+"' ";   //183,186
				
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
		        SqlCommand cmd_checkuserexists = new SqlCommand(sql_gys_id, conn);            
                Object obj_check_gys_exist = cmd_checkuserexists.ExecuteScalar();
				if (obj_check_gys_exist != null)
                {
                  int count = Convert.ToInt32(obj_check_gys_exist);
                  if (count != 0)  
                  {  //��� ��Ӧ���Լ��޸Ĵ���˱� �м�¼ ��ѯ�������
			         string str_select = "select ������� from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid_frist+"'";
			         SqlDataAdapter da_select = new SqlDataAdapter (str_select,conn);
			         DataSet ds_select = new DataSet();
			         da_select.Fill(ds_select,"��Ӧ���Լ��޸Ĵ���˱�");
			         DataTable dt_select = ds_select.Tables[0];
			         sp_result = Convert.ToString(dt_select.Rows[0]["�������"]); 
			        if(sp_result!="")
			        {
                     if (sp_result.Equals("ͨ��"))
                     {  				  
				       //�������ͨ�� ˵���޸ĵĹ�Ӧ����Ϣ��Ч �� ��Ӧ���Լ��޸Ĵ���˱� ��Ч���ݸ��µ����Ϲ�Ӧ����Ϣ��
                       string sql = "update  ���Ϲ�Ӧ����Ϣ�� set ��Ӧ��=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid_frist+"'),"
				       +"��ַ=(select ��˾��ַ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid_frist+"'),�绰=(select ��˾�绰 from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid_frist+"'),"
					   +"��ҳ=(select ��˾��ҳ from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid_frist+"'),����=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid_frist+"'),"
				       +"��ϵ��=(select ��ϵ������ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid_frist+"'),��ϵ���ֻ�=(select ��ϵ�˵绰 from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid_frist+"'),"
					   +"��������=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid_frist+"'),"
					   +"��Ӫ��Χ=(select ��Ӫ��Χ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid_frist+"') where gys_id ='"+gysid_frist+"'";
                     
                       SqlCommand cmd2 = new SqlCommand(sql, conn);
                       int ret = (int)cmd2.ExecuteNonQuery();
					 
					   String str_gysxx = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+gysid_frist+"' ";
                       SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			           DataSet ds_gysxx = new DataSet();
                       da_gysxx.Fill(ds_gysxx, "���Ϲ�Ӧ����Ϣ��");
                       dt_gysxx = ds_gysxx.Tables[0];					 
				     
					   Response.Write("��ϲ��!!!���޸ĵ������Ѿ�����,����!");
                     }
			        if (sp_result.Equals("��ͨ��"))
                    {
                       string sql_delete = "delete  ��Ӧ���Լ��޸Ĵ���˱� where gys_id ='"+gysid_frist+"' ";					
                    
                       SqlCommand cmd_delete = new SqlCommand(sql_delete, conn);
                       int ret = (int)cmd_delete.ExecuteNonQuery();
			         
					   Response.Write("���ύ�޸ĵ����ݲ�����,��������д�����ύ!");
                    }
				    if (sp_result.Equals("�����"))
                    {
                       String str_gysxx = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,��˾����,��˾����,��ϵ������,��ϵ�˵绰,"
					   +"��Ӫ��Χ,gys_id  from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid_frist+"' ";
                       SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			           DataSet ds_gysxx = new DataSet();
                       da_gysxx.Fill(ds_gysxx, "��Ӧ���Լ��޸Ĵ���˱�");
                       dt_gysxx = ds_gysxx.Tables[0];
			         
					   Response.Write("��˵���!");
                    }
			      }  
                 }
			    }
			 }
		        
		   }
		  }
		    string _id ="";			
			if(Session["scsid"]!=null)
			{
			  _id= Convert.ToString(Session["scsid"]);
			  
			}
          
		 if(_id!="")
		  { 
		  
			if (gys_types.Equals("������"))
			{        								             			             				
			  string sql_gys_id = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+_id+"' ";
		      SqlCommand cmd_checkuserexists = new SqlCommand(sql_gys_id, conn);            
              Object obj_check_gys_exist = cmd_checkuserexists.ExecuteScalar();
		      if (obj_check_gys_exist != null)
              {
                 int count = Convert.ToInt32(obj_check_gys_exist);
                 if (count != 0)  
                 {  //��� ��Ӧ���Լ��޸Ĵ���˱� �м�¼ ��ѯ�������
			        string str_select = "select ������� from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+_id+"'";
			        SqlDataAdapter da_select = new SqlDataAdapter (str_select,conn);
			        DataSet ds_select = new DataSet();
			        da_select.Fill(ds_select,"��Ӧ���Լ��޸Ĵ���˱�");
			        DataTable dt_select = ds_select.Tables[0];
			        sp_result = Convert.ToString(dt_select.Rows[0]["�������"]); 
			        if(sp_result!="")
			        {
                     if (sp_result.Equals("ͨ��"))
                     {  
				  
				       //�������ͨ�� ˵���޸ĵĹ�Ӧ����Ϣ��Ч �� ��Ӧ���Լ��޸Ĵ���˱� ��Ч���ݸ��µ����Ϲ�Ӧ����Ϣ��
                       string sql = "update  ���Ϲ�Ӧ����Ϣ�� set ��Ӧ��=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+_id+"'),"
				       +"��ַ=(select ��˾��ַ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+_id+"'),�绰=(select ��˾�绰 from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+_id+"'),"
					   +"��ҳ=(select ��˾��ҳ from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+_id+"'),����=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+_id+"'),"
				       +"��ϵ��=(select ��ϵ������ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+_id+"'),��ϵ���ֻ�=(select ��ϵ�˵绰 from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+_id+"'),"
					   +"��������=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+_id+"'),"
					   +"��Ӫ��Χ=(select ��Ӫ��Χ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+_id+"') where gys_id ='"+_id+"'";
                     
                       SqlCommand cmd2 = new SqlCommand(sql, conn);
                       int ret = (int)cmd2.ExecuteNonQuery();
					 
					   String str_gysxx = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+_id+"' ";
                       SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			           DataSet ds_gysxx = new DataSet();
                       da_gysxx.Fill(ds_gysxx, "���Ϲ�Ӧ����Ϣ��");
                       dt_gysxx = ds_gysxx.Tables[0];
					   if (Session["scsid"] != null) 
		               {
			            Session["scsid"] = null;            		     
		               }
				     
					   Response.Write("��ϲ��!���޸ĵ������Ѿ�����,����!");
                     }
			        if (sp_result.Equals("��ͨ��"))
                     {
                       string sql_delete = "delete  ��Ӧ���Լ��޸Ĵ���˱� where gys_id ='"+_id+"' ";					
                    
                       SqlCommand cmd_delete = new SqlCommand(sql_delete, conn);
                       int ret = (int)cmd_delete.ExecuteNonQuery();
			         
					   Response.Write("���ύ�޸ĵ����ݲ�����,��������д�����ύ!");
                    }
				    if (sp_result.Equals("�����"))
                    {
                       String str_gysxx = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,��˾����,��˾����,��ϵ������,��ϵ�˵绰,"
					   +"��Ӫ��Χ,gys_id  from ��Ӧ���Լ��޸Ĵ���˱�  where gys_id ='"+_id+"'";
                       SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			           DataSet ds_gysxx = new DataSet();
                       da_gysxx.Fill(ds_gysxx, "��Ӧ���Լ��޸Ĵ���˱�");
                       dt_gysxx = ds_gysxx.Tables[0];
			         
					   Response.Write("��˵���!");
                    }
			      }
                }
			  }
            }				
            if (gys_types.Equals("������"))
			{                                								
			   string sql_gys_id = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+_id+"' ";
		       SqlCommand cmd_checkuserexist = new SqlCommand(sql_gys_id, conn);            
               Object obj_check_gys_exist = cmd_checkuserexist.ExecuteScalar();
			   if (obj_check_gys_exist != null)
               {
                int count = Convert.ToInt32(obj_check_gys_exist);
                if (count != 0)  
                {  //��� ��Ӧ���Լ��޸Ĵ���˱� �м�¼ ��ѯ�������
			      string str_select = "select ������� from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+_id+"'";
			      SqlDataAdapter da_select = new SqlDataAdapter (str_select,conn);
			      DataSet ds_select = new DataSet();
			      da_select.Fill(ds_select,"��Ӧ���Լ��޸Ĵ���˱�");
			      DataTable dt_select = ds_select.Tables[0];
			      sp_result = Convert.ToString(dt_select.Rows[0]["�������"]); 
			      if(sp_result!="")
			      {
                    if (sp_result.Equals("ͨ��"))
                    {  
				  
				     //�������ͨ�� ˵���޸ĵĹ�Ӧ����Ϣ��Ч �� ��Ӧ���Լ��޸Ĵ���˱� ��Ч���ݸ��µ����Ϲ�Ӧ����Ϣ��
                     string sql = "update  ���Ϲ�Ӧ����Ϣ�� set ��Ӧ��=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+_id+"'),"
				     +"��ַ=(select ��˾��ַ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+_id+"'),�绰=(select ��˾�绰 from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+_id+"'),"
					 +"��ҳ=(select ��˾��ҳ from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+_id+"'),����=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+_id+"'),"
				     +"��ϵ��=(select ��ϵ������ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+_id+"'),��ϵ���ֻ�=(select ��ϵ�˵绰 from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+_id+"'),"
					 +"��������=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+_id+"'),"
					 +"��Ӫ��Χ=(select ��Ӫ��Χ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+_id+"') where gys_id ='"+_id+"'";
                     
                     SqlCommand cmd2 = new SqlCommand(sql, conn);
                     int ret = (int)cmd2.ExecuteNonQuery();
				     
					 String str_gysxx = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+_id+"' ";
                     SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			         DataSet ds_gysxx = new DataSet();
                     da_gysxx.Fill(ds_gysxx, "���Ϲ�Ӧ����Ϣ��");
                     dt_gysxx = ds_gysxx.Tables[0];
					  if (Session["scsid"] != null) 
		             {
			            Session["scsid"] = null;            		     
		             }
					 Response.Write("��ϲ��!���޸ĵ������Ѿ�����,����!");
                   }
			      if (sp_result.Equals("��ͨ��"))
                   {
                     string sql_delete = "delete  ��Ӧ���Լ��޸Ĵ���˱� where gys_id ='"+_id+"' ";
					
                    
                     SqlCommand cmd_delete = new SqlCommand(sql_delete, conn);
                     int ret = (int)cmd_delete.ExecuteNonQuery();
			         
					 Response.Write("���ύ�޸ĵ����ݲ�����,��������д�����ύ!");
                   }
				   if (sp_result.Equals("�����"))
                   {
                     String str_gysxx = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,��˾����,��˾����,��ϵ������,��ϵ�˵绰,"
					 +"��Ӫ��Χ,gys_id  from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id ='"+_id+"'and ��λ����='������' ";
                     SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			         DataSet ds_gysxx = new DataSet();
                     da_gysxx.Fill(ds_gysxx, "��Ӧ���Լ��޸Ĵ���˱�");
                     dt_gysxx = ds_gysxx.Tables[0];
			         
					 Response.Write("��˵���!");
                   }
			     }
               }
			 }
		    }
		 }

            
			conn.Close();
			%>
		    </span>
			
			<%	
            
			
			
			if (gys_types.Equals("������"))
			{
			%>
			<div class="zjgxs">
			<select name="" class="fug" style="width:200px" onchange="Update_scs(this.options[this.options.selectedIndex].value)">
			 <% foreach(var v in Items1){			
			%>			
			<option value="<%=v.Gys_sid%>"><%=v.Gys_name%></option>
			<%}%>
			
			</select> 
			<span class="zjgxs1"><a href="#">�����µĹ�����</a></span>
			</div>
			<%}%>
            <span class="fxsxx1">��˾����ϸ��Ϣ����:</span>

            <div class="fxsxx2">
                <dl>
                    <dd>��˾���ƣ�</dd>
                    <dt>
					<%if (sp_result.Equals("�����")){%>
                        <input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>" />
						<%}else{%>
						<input name="companyname" type="text" id="companyname" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӧ��"] %>" />
						<%}%>
					</dt>
					
                    <dd>��˾��ַ��</dd>
                    <dt>
					<%if (sp_result.Equals("�����")){%>
                        <input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ַ"] %>"/>
						<%}else{%>
						<input name="address" type="text" id="address" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ��ַ"] %>"/>
						<%}%>
						</dt>
						
                    <dd>��˾�绰��</dd>
                    <dt>
					<%if (sp_result.Equals("�����")){%>
                        <input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾�绰"] %>"/>
						<%}else{%>
						<input name="tel" type="text" id="tel" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["�绰"] %>"/>
						<%}%>
						</dt>
						
                    <dd>��˾��ҳ��</dd>
                    <dt>
					<%if (sp_result.Equals("�����")){%>
                        <input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾��ҳ"] %>" />
						<%}else{%>
						<input name="homepage" type="text" id="homepage" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ҳ"] %>" />
						<%}%>
						</dt>
						
                    <dd>��˾���棺</dd>
                    <dt>
					<%if (sp_result.Equals("�����")){%>
                        <input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>"/>
						<%}else{%>
						<input name="fax" type="text" id="fax" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["����"] %>"/>
						<%}%>
						</dt>
						
                    <dd>��˾������</dd>
                    <dt>
					<%if (sp_result.Equals("�����")){%>
                        <input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��˾����"] %>"/>
						<%}else{%>
						<input name="area" type="text" id="area" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��������"] %>"/>
						<%}%>
						</dt>
                    

   <!--
     <dd>��˾logo��</dd>
    <dt><span class="hhh1"><img src="images/wwwq_03.jpg" /></span> <span class="hhh"><img src="images/eqwew.jpg" /></span></dt>
     <dd>��˾ͼƬ��</dd>
    <dt><div class="fgstp1"><div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div>
        <div class="fgstp"><img src="images/wwwq_03.jpg" /> <span class="fdlpp1"><input name="" type="checkbox" value="" class="fxsfxk" />ѡ��ɾ��</span></div></div>
        <span class="scyp"><a href="#"><img src="images/wqwe_03.jpg" /></a></span>  <span class="scyp"><a href="#"><img src="images/sssx_03.jpg" /></a></span></dt>
    
    -->



                    <dd>��ϵ��������</dd>
                    <dt>
					<%if (sp_result.Equals("�����")){%>
                        <input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ������"] %>" />
						<%}else{%>
						<input name="name" type="text" id="name" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ��"] %>" />
						<%}%>
						</dt>
						
                    <dd>��ϵ�˵绰��</dd>
                    <dt>
					<%if (sp_result.Equals("�����")){%>
                        <input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ�˵绰"] %>" />
                        <%}else{%>
						<input name="phone" type="text" id="phone" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��ϵ���ֻ�"] %>" />
						<%}%>
                    </dt>
					
					 <dd>��Ӫ��Χ��</dd>
                    <dt>
					<%if (sp_result.Equals("�����")){%>
                        <input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" />
                        <%}else{%>
						<input name="Business_Scope" type="text" id="Business_Scope" class="fxsxx3" value="<%=dt_gysxx.Rows[0]["��Ӫ��Χ"] %>" />
						<%}%>
                    </dt>


                </dl>
                <span class="fxsbc">
                    <input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" value=""/>
                    <input type="submit" value="����" />

                </span>
                     </form>
                <div class="ggspp">
                    <span class="ggspp1">��˾Ʒ������</span>
                    
                    <% foreach (System.Data.DataRow row in dt_ppxx.Rows){%>
                    <div class="fgstp">
                        <img src="images/wwwq_03.jpg" />
                        <span class="fdlpp1">
                            <input name="brand" type="checkbox" value="<%=row["pp_id"].ToString() %>" class="fxsfxk" />
                            <%=row["Ʒ������"].ToString() %>
                        </span>
                    </div>

                    <%} %>
                    
                </div>
            </div>
             <span class="fxsbc"><a style="color: Red" onclick="DeleteBrand()">ɾ��ѡ��Ʒ��</a></span>
            <span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand(<%=gys_id %>)">������Ʒ��</a></span>
        </div>
    



	  

    <script>
        function AddNewBrand(id)
        {
             var url = "xzpp.aspx?gys_id=" + id;
             window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
        }
        function DeleteBrand()
        {
            var r = confirm("��ȷ������ɾ����Ʒ��!");
            if (r == true) {

                var brand_str = "?pp_id=";
                var brands = document.getElementsByName("brand");

                for (var i = 0; i < brands.length; i++) {
                    if (brands[i].checked) {

                        brand_str = brand_str + "," + brands[i].value;
                    }

                }

                var url = "scpp.aspx" + brand_str;
                window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
            }
        }
    </script>


    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->  



</body>
</html>
