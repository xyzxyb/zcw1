<!--
        ��Ӧ�̲�����Ϣҳ  (δ��)
        �ļ���:  gysbuxx.aspx   
        
-->


<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>��Ӧ�̲�����Ϣҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
   
</head>

<script runat="server">
        protected DataTable dt_yh = new DataTable();  //��Ӧ�̲�����Ϣ(�û���)    
    DataConn objConn=new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {            
			
            string yh_id = Convert.ToString(Session["yh_id"]); 	 //��ȡ�����û�id	 
			//String yh_id = "29"; 	 //��ȡ�����û�id	
            if(yh_id!="")
			{
              string str_gysxx = "select ��˾����,��˾��ַ,��˾�绰,��˾��ҳ,�ֻ�,����,QQ����,����,�Ƿ���֤ͨ�� from �û��� where  yh_id='"+yh_id+"' ";
              
              dt_yh =objConn.GetDataTable(str_gysxx); 	              
            }		            	
        }				   
</script>

<script language="javascript">

     function Form_submit(){
	    
        if(document.form1.gys_name.value=="")
        {
          alert("��˾���Ʋ���Ϊ��,����д!");
          document.form1.gys_name.focus();
          return false;
        }
        else if(document.form1.gys_address.value=="")
        {
         alert("��˾��ַ����Ϊ��,����д!");
         document.form1.gys_address.focus();
         return false;
        }
		//else if(document.form1.gys_homepage.value=="")
        //{
         //alert("��˾����ҳ����Ϊ��,����д");
         //document.form1.gys_homepage.focus();
         //return false;
        //}
		else if(document.form1.gys_phone.value=="")
        {
         alert("��˾�绰����Ϊ��,����д!");
         document.form1.gys_phone.focus();
         return false;
        }
		else if(document.form1.user_name.value=="")
        {
         alert("������������Ϊ��,����д!");
         document.form1.user_name.focus();
         return false;
        }
		else if(document.form1.user_phone.value=="")
        {
         alert("����ֻ����벻��Ϊ��,����д");
         document.form1.user_phone.focus();
         return false;
        }
     }
</script>


<body>

<!-- ͷ��2��ʼ-->
<uc2:Header2 ID="Header2" runat="server" />
<!-- ͷ��2����-->

<form name="form1" action="gysbtxx2.aspx" method="post" onsubmit="return Form_submit()">

<div class="gytb">

<div class="gybtl"><img src="images/www_03.jpg" /></div>
<div class="gybtr">
<dl>

<span>
<span id="msg" style="color:Red;font-size:14px">
<%
              foreach(System.Data.DataRow row in dt_yh.Rows)
			   {
			     if(Convert.ToString(row["��˾����"])!="")
				 {
			      if(Convert.ToString(row["�Ƿ���֤ͨ��"])==""||Convert.ToString(row["�Ƿ���֤ͨ��"])=="�����")
				  {
				  
				     Response.Write("�����ĵȺ�,�����������ύ,������˵���,�ҷ�����");
                     Response.Write("<br>");
					 Response.Write("��Ա�ᾡ�������!");
					 Response.Write("<br>");
					 Response.Write("<dd>");
					 Response.Write("������Ϣ����:");
					 Response.Write("</dd>");
					 Response.Write("<dt>");
					 Response.Write("</dt>");
				  }
				  if(Convert.ToString(row["�Ƿ���֤ͨ��"])=="ͨ��")
				  {
				     Response.Write("��ϲ��!�����ͨ��,���Զ��������̽�������.");				 
					 Response.Write("<br>");								 
					 Response.Write("<dd>");
					 Response.Write("������Ϣ����:");
					 Response.Write("</dd>");
					 Response.Write("<dt>");
					 Response.Write("</dt>");
				  }
				  if(Convert.ToString(row["�Ƿ���֤ͨ��"])=="��ͨ��")
				  {
				     Response.Write("���δͨ��,�����������Ϣ!");
					 Response.Write("<br>");								 
					 Response.Write("<dd>");
					 Response.Write("������Ϣ����:");
					 Response.Write("</dd>");
					 Response.Write("<dt>");
					 Response.Write("</dt>");
				  } 
				 }
			   }                   
			 
%>
</span>


<dd>*��˾���ƣ�</dd>  <dt><input name="gys_name" type="text" class="ggg" value="<%=dt_yh.Rows[0]["��˾����"] %>"  /></dt>
<dd>*��˾��ַ��</dd>  <dt><input name="gys_address" type="text" class="ggg" value="<%=dt_yh.Rows[0]["��˾��ַ"] %>"/></dt>
<dd>*��˾�绰��</dd>  <dt><input name="gys_phone" type="text" class="ggg" value="<%=dt_yh.Rows[0]["��˾�绰"] %>"/></dt>
<dd>&nbsp��˾��ҳ��</dd>  <dt><input name="gys_homepage" type="text" class="ggg" value="<%=dt_yh.Rows[0]["��˾��ҳ"] %>"/></dt>


<dd>&nbsp��˾�ǣ�</dd>    
<!--
<dt><input name="gys_type" type="radio" value="scs" checked>������  
    <input name="gys_type" type="radio" value="fxs" />������ </dt>
-->	
                            <dt>
						    <select name="scs_type" id="scs_type" style="width: 120px; color: Blue">
                            <option value="������">������</option>
                            <option value="������">������</option>                        
                            </select>
							</dt>

<dd>*����������</dd>    <dt><input name="user_name" type="text" class="ggg" value="<%=dt_yh.Rows[0]["����"] %>"/></dt>
<dd>*�����ֻ���</dd>    <dt><input name="user_phone" type="text" class="ggg" value="<%=dt_yh.Rows[0]["�ֻ�"] %>"/></dt>
<dd>&nbsp����QQ���룺</dd>  <dt><input name="user_qq" type="text" class="ggg" value="<%=dt_yh.Rows[0]["QQ����"] %>"/></dt>

<!--
<dd>��˾��Ӫҵִ�գ� </dd><dt><input name="gys_license" type="file" class="ggg" /> 
    <a href=""><img src="images/sc_03.jpg" /></a></dt>
-->
	
</dl>
<span class="gybtan">
    
	<!--
	
    <a href="" onclick="formsubmit()"><img src="images/aaaa_03.jpg" /></a>
	-->
	
	<input name="gys_id" type="hidden" id="gys_id" class="fxsxx3" value=""/>
    <input type="submit" value="����" OnClick="Form_submit()"/>
	</span></div>
	<dd><span class="gybtr">*�ŵ�Ϊ������,����Ϊ��!</span></dd><dt></dt>
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


</div>


</body>
</html>
