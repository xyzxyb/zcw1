<!--      
	   �����������Ϣ �޸ı�������������Ϣ ɾ��ѡ��Ʒ�� �����µ�Ʒ��
       �ļ�����glfxsxx.aspx 
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
    <title>�����������Ϣ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script type="text/javascript" language="javascript">

    function Update_gys(id) {

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
                var myobj = eval(json);              //�����ص�JSON�ַ���ת��JavaScript���� 			


                for (var i = 0; i < myobj.length; i++) {  //����,��ajax���ص�������䵽�ı�����				

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
        xmlhttp.open("GET", "glfxsxx3.aspx?id=" + id, true);
        xmlhttp.send();
    }


</script>
	
<script runat="server">

       
        public List<GYS_Objects> Items2 { get; set; }
		public List<Fxs_id> Items_id { get; set; }
		public class GYS_Object
        { //����
           public string Sid { get; set; }          		
        }
        public class GYS_Objects
        { //����
            public string Gys_sid { get; set; }
            public string Gys_name { get; set; }
        }
		public class Fxs_id
		{
		    public string Id{get; set;}
		}
		
        protected DataTable dt_gysxx = new DataTable();  //��������Ϣ(���Ϲ�Ӧ����Ϣ��)
        protected DataTable dt_ppxx = new DataTable();  //Ʒ����Ϣ(Ʒ���ֵ�)
		protected DataTable dt_gys_name = new DataTable();  //�����б�Ӧ�̵�����(���Ϲ�Ӧ����Ϣ��)
        protected string gys_id;
        DataConn objConn=new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {
			
            string yh_id = Convert.ToString(Session["yh_id"]);   //��ȡ�û�id
		
			
			string str_type = "select ��λ���� ,gys_id from  ���Ϲ�Ӧ����Ϣ�� where yh_id='"+yh_id+"' ";  //��ѯ��λ����

            DataTable dt_type = objConn.GetDataTable(str_type);
			string gys_type = Convert.ToString(dt_type.Rows[0]["��λ����"]);
			string gys_type_id = Convert.ToString(dt_type.Rows[0]["gys_id"]);  //��Ӧ��id   141
			if (gys_type.Equals("������"))
			{
              string str_gys_id = "select gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='"+yh_id+"' " ;//��ѯ��Ӧ��id			
            
              DataTable dt_gys_id = objConn.GetDataTable(str_gys_id);
			  string str_gysid = Convert.ToString(dt_gys_id.Rows[0]["gys_id"]);   //��ȡ��Ӧ��id
			
			  string str_pp_id = "select pp_id from Ʒ���ֵ� where scs_id='"+str_gysid+"' "; //��ѯƷ��id		
            
              DataTable dt_pp_id = objConn.GetDataTable(str_pp_id);
			  string str_ppid = Convert.ToString(dt_pp_id.Rows[0]["pp_id"]);   //��ȡƷ��id
			
			  string str_fxs_id = "select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='"+str_ppid+"' "; //��ѯ������id		
              DataTable dt_fxs_id = objConn.GetDataTable(str_fxs_id);
			
			
              this.Items2 = new List<GYS_Objects>();
              for(int x=0;x<dt_fxs_id.Rows.Count;x++)
              {
                DataRow dr2 = dt_fxs_id.Rows[x];                                 		     
 			    GYS_Object item = new GYS_Object();                
                item.Sid = Convert.ToString(dr2["fxs_id"]);    //����ͬ��fxs_id���뼯��
                string sid = item.Sid;
                String str_gys_name = "select ��Ӧ��,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='" + sid + "' and ��λ����='������' ";
                DataTable dt = objConn.GetDataTable(str_gys_name);
                
               
                GYS_Objects ite = new GYS_Objects();
                ite.Gys_name = Convert.ToString(dt.Rows[0]["��Ӧ��"]);  //ûѭ��һ�� ��ѭ���ķ����̴��뼯��
                ite.Gys_sid = Convert.ToString(dt.Rows[0]["gys_id"]);
                this.Items2.Add(ite); 
			  }
            
            
			  string str_fxsid = Convert.ToString(dt_fxs_id.Rows[0]["fxs_id"]);   //��ȡ��һ��������id			
			  //���ݲ�ͬ�ķ�����id ��ѯ��ͬ�ķ�������Ϣ
              string str_gysxx = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+str_fxsid+"' ";
            
              dt_gysxx = objConn.GetDataTable(str_gysxx);
			  
			 dt_ppxx=objConn.GetDataTable("select Ʒ������,pp_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where �Ƿ�����='1' and fxs_id='"+str_fxsid+"' ");
			}
			if (gys_type.Equals("������"))
			{
               //����Ƿ�������Ϣ ֱ�Ӹ���yh_id ��ѯ��Ӧ����Ϣ 
               string str_gysxx = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id "
			   +"from ���Ϲ�Ӧ����Ϣ�� where  yh_id='"+yh_id+"' ";
              
               dt_gysxx = objConn.GetDataTable(str_gysxx);
			   string fxs_id = Convert.ToString(dt_gysxx.Rows[0]["gys_id"]);
			   
			   dt_ppxx=objConn.GetDataTable("select Ʒ������,pp_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where �Ƿ�����='1' and fxs_id='"+fxs_id+"' "); 
			}
           
            if (dt_gysxx.Rows.Count == 0) 
			Response.Redirect("gyszym.aspx");
          

        }

       		
	
</script>

<body>

    <!-- ͷ����ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ������-->


    <form id="update_fxs" name="update_fxs" action="glfxsxx2.aspx" method="post">
       <div class="fxsxx">
	   <span class="fxsxx1">
	   <%
		
		  string sp_result = "";        //�������������������

          
          string  id = Request["id"];    
		  if(id!=null&id!="")
			{			  
			  Session["id"] = id;  //����ȡ��ֵ����session
			}
		  if (Session["id"] == null) 
		  {
		  if(id==null||id=="")    //���ӹ�Ӧ����ҳ�����ӵ� ���������ҳ��ʱ id=null ���޸ı���󷵻�ʱid=""  
		  {
            String yh_id = Convert.ToString(Session["yh_id"]);   //��ȡ�û�id       
			string str_gys_id = "select ��λ����, gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='"+yh_id+"' " ;//��ѯ��Ӧ��id			
            
            DataTable dt_gys_id = objConn.GetDataTable(str_gys_id);
			string str_gysid = Convert.ToString(dt_gys_id.Rows[0]["gys_id"]);   //��ȡ��Ӧ��id   141
			string str_gysid_type = Convert.ToString(dt_gys_id.Rows[0]["��λ����"]);
			
			
			if(str_gysid_type.Equals("������"))
			{
			   string str_pp_id = "select pp_id from Ʒ���ֵ� where scs_id='"+str_gysid+"' "; //��ѯƷ��id		
             
               DataTable dt_pp_id =objConn.GetDataTable(str_pp_id);
			   string str_ppid = Convert.ToString(dt_pp_id.Rows[0]["pp_id"]);   //��ȡƷ��id	185
            
			   
		       string sql_gys_id = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id in (select top 1 fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='"+str_ppid+"')";
		            
               Object obj_check_gys_exist = objConn.DBLook(sql_gys_id);
		

               if (obj_check_gys_exist != null)
               {
                  int count = Convert.ToInt32(obj_check_gys_exist);
                  if (count != 0)  
                  {  //��� ��Ӧ���Լ��޸Ĵ���˱� �м�¼ ��ѯ�������
			         string str_select = "select �������,gys_id from ��Ӧ���Լ��޸Ĵ���˱� where gys_id in (select top 1 fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='"+str_ppid+"')";
			        
			         DataTable dt_select = objConn.GetDataTable(str_select);
			         sp_result = Convert.ToString(dt_select.Rows[0]["�������"]);   //ͨ��
				     string gysid = Convert.ToString(dt_select.Rows[0]["gys_id"]);    //139
			         if(sp_result!="")
			         {
                      if (sp_result.Equals("ͨ��"))
                      {  
				  
				         //�������ͨ�� ˵���޸ĵĹ�Ӧ����Ϣ��Ч �� ��Ӧ���Լ��޸Ĵ���˱� ��Ч���ݸ��µ����Ϲ�Ӧ����Ϣ��
                         string sql = "update  ���Ϲ�Ӧ����Ϣ�� set ��Ӧ��=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),"
				         +"��ַ=(select ��˾��ַ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),�绰=(select ��˾�绰 from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),"
					     +"��ҳ=(select ��˾��ҳ from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid+"'),����=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),"
				         +"��ϵ��=(select ��ϵ������ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),��ϵ���ֻ�=(select ��ϵ�˵绰 from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid+"'),"
					     +"��Ӫ��Χ=(select ��Ӫ��Χ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"') where gys_id ='"+gysid+"'";

                         int ret = objConn.ExecuteSQLForCount(sql,false);
						 //this.Load += new EventHandler(Page_Load);      //���µ���ҳ�� û�ɹ�
						 
						 string str_gysxx = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+gysid+"' ";
                      
                         dt_gysxx = objConn.GetDataTable(str_gysxx);
				     
					     Response.Write("��ϲ��!!���޸ĵ������Ѿ�����,����!");
                      }
			          if (sp_result.Equals("��ͨ��"))
                      {
                         string sql_delete = "delete  ��Ӧ���Լ��޸Ĵ���˱� where gys_id ='"+gys_id+"' ";			                     
                        
                          int ret = objConn.ExecuteSQLForCount(sql_delete,false);
			         
					    Response.Write("���ύ�޸ĵ����ݲ�����,��������д�����ύ!");
                      }
					  if (sp_result.Equals("�����"))
                     {
					   //�޸��ύ�� ҳ������ʾ���� ��Ӧ���Լ��޸Ĵ���˱� ����Ϣ
					   
					   string str_gysxx = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,��˾����,��˾����,��ϵ������,��ϵ�˵绰,"
					  +"��Ӫ��Χ,gys_id  from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id ='"+gysid+"' ";
                      
                      
                       dt_gysxx = objConn.GetDataTable(str_gysxx);
			         
					   Response.Write("��˵���!");
                     }
			        }
                  }
			   }     
			}
			if(str_gysid_type.Equals("������"))
			{		             			   
		      string sql_gys_id = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+str_gysid+"' ";
		          
              Object obj_check_gys_exist = objConn.DBLook(sql_gys_id);	
              if (obj_check_gys_exist != null)
              {
                 int count = Convert.ToInt32(obj_check_gys_exist);
                 if (count != 0)  
                 {  //��� ��Ӧ���Լ��޸Ĵ���˱� �м�¼ ��ѯ�������
			        string str_select = "select �������,gys_id from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+str_gysid+"' ";			
			      
			        DataTable dt_select = objConn.GetDataTable(str_select);
			        sp_result = Convert.ToString(dt_select.Rows[0]["�������"]);   //ͨ��
				    string gysid = Convert.ToString(dt_select.Rows[0]["gys_id"]);    //139
			        if(sp_result!="")
			        {
                      if (sp_result.Equals("ͨ��"))
                      {  				  
				        //�������ͨ�� ˵���޸ĵĹ�Ӧ����Ϣ��Ч �� ��Ӧ���Լ��޸Ĵ���˱� ��Ч���ݸ��µ����Ϲ�Ӧ����Ϣ��
                        string sql = "update  ���Ϲ�Ӧ����Ϣ�� set ��Ӧ��=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),"
				        +"��ַ=(select ��˾��ַ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),�绰=(select ��˾�绰 from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),"
					    +"��ҳ=(select ��˾��ҳ from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid+"'),����=(select ��˾���� from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),"
				        +"��ϵ��=(select ��ϵ������ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"'),��ϵ���ֻ�=(select ��ϵ�˵绰 from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+gysid+"'),"
					    +"��Ӫ��Χ=(select ��Ӫ��Χ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+gysid+"') where gys_id ='"+gysid+"'";

                      int ret = objConn.ExecuteSQLForCount(sql,false);
						//this.Load += new System.EventHandler(Page_Load);  
						
						string str_gysxx = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+gysid+"' ";
                       
                        dt_gysxx = objConn.GetDataTable(str_gysxx);
                        					
				     
					    Response.Write("��ϲ��!!���޸ĵ������Ѿ�����,����!");
                      }
			         if (sp_result.Equals("��ͨ��"))
                     {
                       string sql_delete = "delete  ��Ӧ���Լ��޸Ĵ���˱� where gys_id ='"+gys_id+"' ";			
                     
                        int ret = objConn.ExecuteSQLForCount(sql_delete,false);
					   Response.Write("���ύ�޸ĵ����ݲ�����,��������д�����ύ!");
                     }
					 if (sp_result.Equals("�����"))
                     {
					   //�޸��ύ�� ҳ������ʾ���� ��Ӧ���Լ��޸Ĵ���˱� ����Ϣ
					   
					   string str_gysxx = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,��˾����,��˾����,��ϵ������,��ϵ�˵绰,"
					  +"��Ӫ��Χ,gys_id  from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id ='"+gysid+"'and ��λ����='������' ";
                      
                       
                       dt_gysxx = objConn.GetDataTable(str_gysxx);
			         
					   Response.Write("��˵���!");
                     }
			       }
                 }
			  }
			}
		  }
		 }
		else
	    {   			
			string _id ="";
			//���session����ֵ �Ͱ�session��ֵ��������_id  ȱ�� ����ͬʱ�޸Ķ��������
			if(Session["id"]!=null)
			{
			  _id= Convert.ToString(Session["id"]);
			  
			}
            if (_id!="") 
			{
			
		    string sql_gys_id = "select count(*) from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+_id +"' ";			
		       
            Object obj_check_gys_exist = objConn.DBLook(sql_gys_id);	
            if (obj_check_gys_exist != null)
            {
               int count = Convert.ToInt32(obj_check_gys_exist);
               if (count != 0)  
               {  //��� ��Ӧ���Լ��޸Ĵ���˱� �м�¼ ��ѯ�������
			    string str_select = "select ������� from ��Ӧ���Լ��޸Ĵ���˱� where gys_id='"+_id+"' ";

			    DataTable dt_select = objConn.GetDataTable(str_select);
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
					 +"��Ӫ��Χ=(select ��Ӫ��Χ from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id='"+_id+"') where gys_id ='"+_id+"'";
                     
                    int ret = objConn.ExecuteSQLForCount(sql_delete,false);
					 
					 string str_gysxx = "select ��Ӧ��,��ϵ��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,��Ӫ��Χ,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+_id+"' ";
                    
                     dt_gysxx = objConn.GetDataTable(str_gysxx);
					 if (Session["id"] != null) 
		             {
			            Session["id"] = null;            		     
		             }
				     
					 Response.Write("��ϲ��!���޸ĵ������Ѿ�����,����!");
                  }
			      if (sp_result.Equals("��ͨ��"))
                  {
                     string sql_delete = "delete  ��Ӧ���Լ��޸Ĵ���˱� where gys_id ='"+_id+"' ";
					
                     
                    int ret = objConn.ExecuteSQLForCount(sql_delete,false);
			        
					 Response.Write("���ύ�޸ĵ����ݲ�����,��������д�����ύ!");
                  }
				  if (sp_result.Equals("�����"))
                     {
					   //�޸��ύ�� ҳ������ʾ���� ��Ӧ���Լ��޸Ĵ���˱� ����Ϣ
					   
					   string str_gysxx = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,��˾����,��˾����,��ϵ������,��ϵ�˵绰,"
					  +"��Ӫ��Χ,gys_id  from ��Ӧ���Լ��޸Ĵ���˱� where  gys_id ='"+_id+"' ";                      
                      
                       dt_gysxx = objConn.GetDataTable(str_gysxx);
			         
					   Response.Write("��˵���!");
                     }
			    }
              }
			}
		  }
		  }
		 //}
		%>
	    </span>		                                
			
			
			<%	
            string user_id = Convert.ToString(Session["yh_id"]);   //��ȡ�û�id 			
			string str_type = "select ��λ���� ,gys_id from  ���Ϲ�Ӧ����Ϣ�� where yh_id='"+user_id+"' ";  //��ѯ��λ����			
            DataTable dt_type = objConn.GetDataTable(str_type);
			string gys_type = Convert.ToString(dt_type.Rows[0]["��λ����"]);
			string gys_type_id = Convert.ToString(dt_type.Rows[0]["gys_id"]);  //��Ӧ��id   141
			//����Ƿ����̾�û�������б�
			
			
			if (gys_type.Equals("������"))
			{
			%>
			<div class="zjgxs">
			<select name="" class="fug" style="width:200px" onchange="Update_gys(this.options[this.options.selectedIndex].value)">
			 <% foreach(var v in Items2){			
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
                    <input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" />
                    <input type="submit" value="����" onclick="Update_gysxx()"/>

                </span>
                     </form>
                <div class="ggspp">
                    <span class="ggspp1">��˾����Ʒ������</span>
                    
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
             <span class="fxsbc"><a style="color: Red" onclick="DeleteBrand()">ȡ��ѡ�еķ���Ʒ��</a></span>
            <span class="fxsbc"><a style="color: Blue" onclick="AddNewBrand(<%=gys_id %>)">�����·���Ʒ��</a></span>
        </div>  
	  

    <script>
        function AddNewBrand(id) {
            var url = "xzfxpp.aspx?gys_id=" + id;
            window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
        }
        function DeleteBrand() {
            var r = confirm("��ȷ������ȡ��������Ʒ��!");
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

        function Update_gysxx() {
            alert("�����µ���Ϣ���ύ,�ȴ����,�뷵��!");
        }
    </script>


    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->   



</body>
</html>































