<!--
       ��Ӧ�̹������ҳ�� ����ɾ��ѡ�еĲ���,��Ҳ�����µĲ���
	   �ļ���:  gysglcl.aspx   
       ����������� 
       
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.IO" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��Ӧ���ղ�ҳ��</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
<style>
 #menu { width:200px; margin:auto;}
 #menu h1 { font-size:12px;margin-top:1px; font-weight:100}
 #menu h2 { padding-left:15px; font-size:12px; font-weight:100}
 #menu ul { padding-left:15px; height:100px;overflow:auto; font-weight:100}
 #menu a { display:block; padding:5px 0 3px 10px; text-decoration:none; overflow:hidden;}
 #menu a:hover{ color:#000;}
 #menu .no {display:none;}
 #menu .h1 a{color:#000;}
 #menu .h2 a{color:#000;}
 #menu  h1 a{color:#000;}
</style>
<script language="JavaScript">
<!--    //
    function ShowMenu(obj, n) {
        var Nav = obj.parentNode;
        if (!Nav.id) {
            var BName = Nav.getElementsByTagName("ul");
            var HName = Nav.getElementsByTagName("h2");
            var t = 2;
        } else {
            var BName = document.getElementById(Nav.id).getElementsByTagName("span");
            var HName = document.getElementById(Nav.id).getElementsByTagName("h1");
            var t = 1;
        }
        for (var i = 0; i < HName.length; i++) {
            HName[i].innerHTML = HName[i].innerHTML.replace("-", "+");
            HName[i].className = "";
        }
        obj.className = "h" + t;
        for (var i = 0; i < BName.length; i++) { if (i != n) { BName[i].className = "no"; } }
        if (BName[n].className == "no") {
            BName[n].className = "";
            obj.innerHTML = obj.innerHTML.replace("+", "-");
        } else {
            BName[n].className = "no";
            obj.className = "";
            obj.innerHTML = obj.innerHTML.replace("-", "+");
        }
    }
//-->
</script>

    <script src="Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">                       
		

     		
    </script>

</head>

<body>


<!-- ͷ����ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ������-->


<script runat="server">

          public List<FLObject_yj> Items1 { get; set; }
          public List<FLObject_ej> Items2 { get; set; }
          public List<CLObject> Cllist { get; set; }
		  public Boolean userIsVIP = false;
		  
		  public class CLObject
          { //����
  	        public string Cl_flbm { get; set; }  //�������(4λ)
            public string Cl_Name { get; set; }  //����Ĳ������� 
            public string Cl_id { get; set; }
          }
		  
		  public class FLObject_yj
          {  //����
  	         public string flbm { get; set; }
             public string YJfl_name { get; set; }             
          }
		  
		  public class FLObject_ej
          { //����
  	         public string Ej_flbm { get; set; }   
             public string Ejfl_Name { get; set; }     
          }
  
          

        protected DataTable dt_cl = new DataTable();    //���ݹ�Ӧ��id��ѯ��ʾ��,�������(���ϱ�)
        protected DataTable dt_yjfl = new DataTable();  //ȡһ��������ʾ����(���Ϸ����)
		protected DataTable dt_ejfl = new DataTable();  //ȡ����������ʾ����(���Ϸ����)
                DataConn objConn=new DataConn();
		protected void Page_Load(object sender, EventArgs e)
		{
		   Products_gys_cl();
		}
		
        protected void Products_gys_cl()
        {
              
			string yh_id = Convert.ToString(Session["yh_id"]);   //��ȡsession��yh_id
			
			//�����û�id ��ѯ��Ӧ��id
			DataTable dt_gys=objConn.GetDataTable("select gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='"+yh_id+"' ");   //141
			string gys_id = Convert.ToString(dt_gys.Rows[0]["gys_id"]);
			
			//���ݹ�Ӧ��id ��ѯ������Ϣ
            dt_cl  = objConn.GetDataTable("select cl_id,��ʾ��,������� from ���ϱ� where gys_id='"+gys_id+"'and �Ƿ�����='1' ");           
        
			////���ݱ�DataTableת����                   
            this.Cllist = new List<CLObject>();
			for(int x=0;x<dt_cl.Rows.Count;x++)
            {
			    DataRow dr2 = dt_cl.Rows[x]; 		      
			    CLObject item = new CLObject();
                item.Cl_Name = Convert.ToString(dr2["��ʾ��"]);   //����Ĳ�������
                item.Cl_flbm = Convert.ToString(dr2["�������"]); //���ݹ�Ӧ��id��ѯ�����������������(������볤��Ϊ4λ)
				item.Cl_id = Convert.ToString(dr2["Cl_id"]);
                this.Cllist.Add(item);              				 //���뼯��
		    } 
			foreach(var v in this.Cllist)    //��������
			{
			   if(v.Cl_flbm.ToString()!=null&Convert.ToString(v.Cl_flbm).Length==4)
			   {
			   string code = v.Cl_flbm.ToString().Substring(0, 2);	//ȡ�������ǰ��λ�ٴν��в�ѯ ���ջ��һ�����������	
			  dt_yjfl = objConn.GetDataTable("select  ��ʾ���� from ���Ϸ���� where �������='"+code+"' ");

			   }
			}
			this.Items1 = new List<FLObject_yj>();
			for(int x=0;x<dt_yjfl.Rows.Count;x++)
            {
			    DataRow dr = dt_yjfl.Rows[x]; 		      
			    FLObject_yj item = new FLObject_yj();
                item.YJfl_name = Convert.ToString(dr["��ʾ����"]);   //һ����������                
                this.Items1.Add(item);              				 //���뼯��
		    } 
			
			//ȡ������������
			dt_ejfl = objConn.GetDataTable("select ��ʾ����,������� from ���Ϸ���� where  "
			+"������� in(select ������� from ���ϱ� where gys_id='"+gys_id+"'and �Ƿ�����='1' )");
        
			this.Items2 = new List<FLObject_ej>();
			for(int x=0;x<dt_ejfl.Rows.Count;x++)
            {
			    DataRow dr = dt_ejfl.Rows[x]; 		      
			    FLObject_ej item = new FLObject_ej();
                item.Ejfl_Name = Convert.ToString(dr["��ʾ����"]);   //������������ 
                item.Ej_flbm = Convert.ToString(dr["�������"]);     //����������� 				
                this.Items2.Add(item);              				 //���뼯��
		    }		                    
		    CancelFollowButton.Attributes.Add("onClick", "return confirm('��ȷ��Ҫɾ����ѡ�еĲ�����');");
        } 
          
          protected void dumpFollowCLs(object sender, EventArgs e)
          {  	               
  	         string yh_id = Session["yh_id"].ToString();
			 
			 //�����û�id ��ѯ��Ӧ��id
			 DataTable dt_gys = objConn.GetDataTable("select gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='"+yh_id+"' ");
           
			 string gys_id = Convert.ToString(dt_gys.Rows[0]["gys_id"]);
  	         
			 //����gys_id ��ѯ���ϱ���ص����� �Ա㵼��excel ���
  	         string query_cl_gys = "select*from ���ϱ� where gys_id='"+gys_id+"' ";  	
  	           
             DataTable cldt = new DataTable();
             cldt = objConn.GetDataTable(query_cl_gys);
             outToExcel(cldt);
         }
		 
		    private StringBuilder  AppendCSVFields(StringBuilder argSource, string argFields)
            {
  	          return argSource.Append(argFields.Replace(",", " ").Trim()).Append(",");
            }
			public static void DownloadFile(HttpResponse argResp, StringBuilder argFileStream, string strFileName)
            {
		      try
		       {
  		          string strResHeader = "attachment; filename=" + Guid.NewGuid().ToString() + ".csv";
   	 	          if (!string.IsNullOrEmpty(strFileName))
   	 	          {
   	 		        strResHeader = "inline; filename=" + strFileName;
  	 	          }
  	 	          argResp.AppendHeader("Content-Disposition", strResHeader);//attachment˵���Ը������أ�inline˵�����ߴ�
   	 	          argResp.ContentType = "application/ms-excel";
   	 	          argResp.ContentEncoding = Encoding.GetEncoding("GB2312"); 
   	 	          argResp.Write(argFileStream);
  	           }
   	          catch (Exception ex)
  	           {
  	 	         throw ex;
   	           }
            }
		    public void outToExcel(DataTable followcls) 
		    {  	
              StringWriter swCSV = new StringWriter();
              StringBuilder sbText = new StringBuilder();
              for (int i = 0; i < followcls.Columns.Count; i++)
              {
        	     AppendCSVFields(sbText,followcls.Columns[i].ColumnName);
              }
              sbText.Remove(sbText.Length - 1, 1);
              swCSV.WriteLine(sbText.ToString());
        
              for (int i = 0; i < followcls.Rows.Count; i++)
              {
        	     sbText.Clear();
        	     for (int j = 0; j < followcls.Columns.Count; j++)
                 {
          	       AppendCSVFields(sbText,followcls.Rows[i][j].ToString());
                 }
                 sbText.Remove(sbText.Length - 1, 1);
        	     swCSV.WriteLine(sbText.ToString());
              }
              string fileName = Path.GetRandomFileName();
              DownloadFile(Response, swCSV.GetStringBuilder(), fileName +".csv");
              swCSV.Close();
              Response.End();
           }
   
</script>



<form id="form1" runat="server">

<script runat="server">
          void Delete_cl(object sender, EventArgs e)
          {
		   
  	        String yh_id = Convert.ToString(Session["yh_id"]);   //��ȡsession��yh_id
			
			//�����û�id ��ѯ��Ӧ��id
			 DataTable dt_gys = objConn.GetDataTable("select gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='"+yh_id+"' ");            
			string gys_id = Convert.ToString(dt_gys.Rows[0]["gys_id"]);
  	        
  	        //��ȡ��ѡ��ѡ�е�cl_id
  	        string clidstr =Request.Form["clid"];
  	        
			//ͨ����ȡ�Ĺ�Ӧ��id��cl_id����ɾ��
  	        string str_cancelfollow = "update ���ϱ� set �Ƿ�����='0' where gys_id ='" +  gys_id + "' and cl_id in (" + clidstr + ")" ;
  	       objConn.ExecuteSQL(str_cancelfollow,true);
            Products_gys_cl();
         }
</script>

<div class="dlqqz">

<div class="dlqqz1"><img src="images/sccp.jpg" /></div>
<span class="dlqqz4"><img src="images/wz_03.jpg" width="530" height="300" /></span>
<div class="dlqqz2">
<div id="menu">

 <% 
 	   int firstlevel = 0;
       foreach (var menu1 in this.Items1){
                    %>
                    <h1 onclick="javascript:ShowMenu(this,<%=firstlevel %>)"><a href="javascript:void(0)">
                    <img src="images/biao2.jpg" /><%=menu1.YJfl_name%> &gt;</a></h1>
                    <span class="no">
                    <% 
 	                  int secondlevel = 0;
 		              foreach (var menu2 in this.Items2){
 	   	  
                    %>
                        <h2 onclick="javascript:ShowMenu(this,<%=secondlevel %> )"><a href="javascript:void(0)">+ <%=menu2.Ejfl_Name%></a></h2>
                        <ul class="no">
                          <% 
                            //�����µķ����ƷҪ����,����Ķ������������в�ѯ					  
                            							
						
                            String yh_id = Convert.ToString(Session["yh_id"]);   //��ȡsession��yh_id							
			                
							//�����û�id ��ѯ��Ӧ��id
			               DataTable dt_gys= objConn.GetDataTable("select gys_id from ���Ϲ�Ӧ����Ϣ�� where yh_id='"+yh_id+"' ");
							
			                string gys_id = Convert.ToString(dt_gys.Rows[0]["gys_id"]);
							string flbm = menu2.Ej_flbm;
							
                           DataTable dt_cls = objConn.GetDataTable("select cl_id,��ʾ��,������� from ���ϱ� where gys_id='"+gys_id+"'and �������='"+flbm+"' ");
                           
                            foreach (System.Data.DataRow row in dt_cls.Rows){
      	        
                            %>
                            <a href="clbj.aspx?cl_id=<%=row["cl_id"]%>"><%=row["��ʾ��"].ToString()%></a><input type="checkbox" name="clid" value="<%=row["cl_id"]%>" />ѡ��                           
							<%    			    
   		                     }
   		       secondlevel++;
                            %>
                        </ul>
                        <% 	         
  	                       }
                        %>
                    </span>
                    <% 
 		firstlevel++;
                     } 
                    %>

        
 
 <span class="no">
 

 </span>
  
</div></div>
<div class="dlqqz3">

<a href="xzclym.aspx"><img src="images/xzcl.jpg" border="0" /></a>&nbsp;

<!--
<a id="btnDeleteBatch" onclick="Delete_cl" href="#"><img src="images/scxzcl.jpg" border="0" /></a>
-->
<asp:ImageButton ID="CancelFollowButton" ImageUrl="images/scxzcl.jpg" runat="server" OnClick="Delete_cl" />

</div>
</div>


<div class="dlex">
            <%
	if (userIsVIP){
            %>            
                <div class="dlex1">
                    <asp:Button runat="server" ID="button1" Text="ѡ�����ݽ��������ڲ�ϵͳ" OnClick="dumpFollowCLs" />
                </div>
            
            <%
	}else {
            %>
            
            <div class="dlex1">
                �����԰������Ĳ������ݵ���Ϊexcel��������ʹ��
                <asp:Button runat="server" ID="button2" Text="ȫ������ΪEXCEL" OnClick="dumpFollowCLs" />
            </div>
            <%
	}	
            %>

</div>
</form> 

<!--  footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->



</body>
</html>



