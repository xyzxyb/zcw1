<!--
             ���ϱ༭ҳ��
             �ļ���:  clbj.aspx 
			 �������: cl_id
-->

<%@ Register Src="include/header2.ascx" TagName="Header2" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>���ϱ༭ҳ��</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script language="javascript">
    //һ�����෢��ajax ���µ���С������� �ļ�����:xzclym2.aspx
    function updateFL(id) 
	{
        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                
                document.getElementById("ejflname").innerHTML = xmlhttp.responseText;
            }
        }
        xmlhttp.open("GET", "xzclym2.aspx?id=" + id, true);
        xmlhttp.send();
              
    }
	
	   //�������෢��ajax ���µ���Ʒ�Ƶ����� 
	   
      function updateCLFL(id) 
	  {
        var xmlhttp;		
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();			
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			 
        }
        xmlhttp.onreadystatechange = function () {
            
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                
                document.getElementById("brand").innerHTML = xmlhttp.responseText;			
            }
        }
        xmlhttp.open("GET", "xzclym3.aspx?id=" + id, true);
        xmlhttp.send();
		
	
	
        }
</script>	

<script runat="server">  
        
         public List<OptionItem> Items1 { get; set; }    //���Ϸ������
         public List<OptionItem_sx> Items2 { get; set; }	 //��������,��������ֵ	 
         public class OptionItem
         {
            public string Name { get; set; }  //�����б���ʾ������
            public string GroupsCode { get; set; }  //�����б�����������    
         }
		 public class OptionItem_sx
         {
            public string Sx_Name { get; set; }      //�����б���������
            public string Sx_value { get; set; }     //�����б��������ֵ    
         }
         protected DataTable dt_clfl = new DataTable();  //���Ϸ������   
         protected DataTable dt_clxx = new DataTable();    //������Ϣ
         protected DataTable dt_clsx = new DataTable();    //������������,����ֵ(�������Ա�)	 
    
         protected void Page_Load(object sender, EventArgs e)
         {
             string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
             SqlConnection conn = new SqlConnection(constr); 
		
		     string cl_id = Request["cl_id"];   //��ȡ����id
			 
             SqlDataAdapter da_clfl = new SqlDataAdapter("select ��ʾ����,������� from ���Ϸ���� where len(�������)='2'", conn);
             DataSet ds_clfl = new DataSet();
             da_clfl.Fill(ds_clfl, "���Ϸ����");
             dt_clfl = ds_clfl.Tables[0];         

             this.Items1 = new List<OptionItem>();  //���ݱ�DataTableת����  
        
             for (int x = 0; x < dt_clfl.Rows.Count; x++)
             {
                DataRow dr = dt_clfl.Rows[x];
                if (Convert.ToString(dr["�������"]).Length == 2)
                {
                   OptionItem item = new OptionItem();
                   item.Name = Convert.ToString(dr["��ʾ����"]);
                   item.GroupsCode = Convert.ToString(dr["�������"]);
                   this.Items1.Add(item);   //��������뼯��
                }
             }    
             String str_clxx = "select ��ʾ��,��������,Ʒ������,����ͺ�,������λ,��λ���,��λ����,�������,˵�� from ���ϱ� where cl_id='"+cl_id+"' ";
             SqlDataAdapter da_clxx = new SqlDataAdapter(str_clxx, conn);
			 DataSet ds_clxx = new DataSet();
             da_clxx.Fill(ds_clxx, "���ϱ�");
             dt_clxx = ds_clxx.Tables[0];
			 
			 String str_clsx = "select ������������,��������ֵ from �������Ա� where cl_id='"+cl_id+"' ";
             SqlDataAdapter da_clsx = new SqlDataAdapter(str_clsx, conn);
			 DataSet ds_clsx = new DataSet();
             da_clsx.Fill(ds_clsx, "���ϱ�");
             dt_clsx = ds_clsx.Tables[0];
			  
			 this.Items2 = new List<OptionItem_sx>();
			 for(int x= 0;x<dt_clsx.Rows.Count;x++)
			 {
			    DataRow dr = dt_clsx.Rows[x];
				OptionItem_sx sx = new OptionItem_sx();
				sx.Sx_Name = Convert.ToString(dr["������������"]);
				sx.Sx_value = Convert.ToString(dr["��������ֵ"]);
				this.Items2.Add(sx);
			 }
         }				
 
</script>
<body>

 <!-- ͷ����ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
 <!-- ͷ������-->
 
<form action="clbj2.aspx" method="post" > 
<div class="fxsxx">
<span class="fxsxx1">���Ϸ�������:</span>
<div class="xz1">
                <div class="xza">

                    <span class="xz2"><a href="#">����</a></span>
                    <select id="drop1" name="drop1" onchange="updateFL(this.options[this.options.selectedIndex].value)">
                        <% foreach(var v  in Items1){%>
                        <option value="<%=v.GroupsCode %>"><%=v.Name%></option>
                        <%}%>
                    </select>
                </div>
                <div class="xza">
                    <span class="xz2"><a href="#">С��</a></span>
                    <select id="ejflname" name="ejflname" class="fux"  onchange="updateCLFL(this.options[this.options.selectedIndex].value)">
                        
                        <option value="0">��ѡ��С��</option>
                    
                    </select>
                </div>           



<div class="xzz">
<!--
<span class="xzz0">���û���ʺϵ�С�࣬����ϵ��վ����Ա���ӣ� ��ϵ��ʽ��xxx@xxx.com.��ʹ��ģ�塣 </span>
-->
<span class="xzz1"><a href="#">ģ�����ص�ַ</a></span>
</div>

</div>

<div class="fxsxx2">
<span class="srcl">������Ϣ����:</span>
 <dl>
                    <dd>�������֣�</dd>
                    <dt>
                        <input name="cl_name" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["��ʾ��"] %>" /></dt>

                    <dd>Ʒ    �ƣ�</dd>
                    <dt>
                        <select name="brand" id="brand" style="width: 300px">
                            
                            <option value="0">��ѡ��Ʒ��</option>
                           
                        </select></dt>
						
				    <dd>��  �ͣ�</dd>
                    <dt>
                        <select name="cp_type" id="cp_type" style="width: 300px">
                            
                             <option value="һ��">һ��</option>
                             <option value="����">����</option>
                             <option value="��Ʒ">��Ʒ</option>
                           
                        </select></dt>
  
                    <dd>�������ƣ�</dd>
                    <dt>
                        <select name="sx_names" id="sx_names" style="width: 300px" >
						
                            <%foreach(var v in this.Items2){%>                                          
                            <option value="0"><%=v.Sx_Name%></option>
							<%}%>
						
                        </select></dt>
						
		  <!--
	                <dd>�������ƣ�</dd>                    
                    <dt>
                        <input name="sx_names" type="text" id="sx_names" class="fxsxx3" value="<%=dt_clxx.Rows[0]["����ͺ�"] %>" /></dt>
			-->				
						
                    <dd>����ֵ��</dd>
                    <dt>
                        <select name="cl_value" id="cl_value" style="width: 300px"  >
                            
                            <%foreach(var v in this.Items2){%>                                          
                            <option value="0"><%=v.Sx_value%></option>
							<%}%>
                           
                        </select></dt>
					
						
					<dd>����ͺţ�</dd>                    
                    <dt>
                        <input name="cl_type" type="text" id="cl_type" class="fxsxx3" value="<%=dt_clxx.Rows[0]["����ͺ�"] %>" /></dt>					
						
                    <dd>������λ��</dd>
                    <dt>
                        <input name="cl_bit" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["������λ"] %>" /></dt>
                    <dd>��λ�����</dd>
                    <dt>
                        <input name="cl_volumetric" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["��λ���"] %>" /></dt>
				    <dd>��λ������</dd>
                    <dt>
                        <input name="cl_height" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["��λ����"] %>" /></dt>
                    <dd>˵����</dd>
                    <dt>
                        <input name="cl_instruction" type="text" class="fxsxx3" value="<%=dt_clxx.Rows[0]["˵��"] %>" /></dt>
                </dl>
</div>

<!--
<div class="cpdt">
   <dl>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>��Ʒ��ͼ1��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
  </dl>
</div>
-->

<div class="cpdt">
<span class="dmt">��ý����Ϣ</span>
   <dl>
     <dd>��Ʒ��Ƶ��</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>�ɹ�������</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
     <dd>�������ϣ�</dd>
    <dt><input name="" type="text" class="fxsxx3"/><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>                          
 </dl>
 <!--
 <span class="fxsbc"><a href="#"><img src="images/bbc_03.jpg" /></a></span>  
 -->
 <span class="fxsbc"><a href="#">
                    <input type="image" name="Submit" value="Submit" src="images/bbc_03.jpg"></a></span>
</div>

</form>

</div>


</div>




<div class="foot">
<span class="foot2"><a href="#">��վ����</a>  |<a href="#"> ���ݼල</a> | <a href="#"> ������ѯ</a> |  <a href="#">Ͷ�߽���010-87654321</a> </span>
<span class="di3"><p>Copyright 2002-2012�ڲ�����Ȩ����      ��ICP֤0000111��      ����������110101000005��</p>
<p>��ַ�������к��������Ŵ���11��  ��ϵ�绰��010-87654321    ����֧�֣���������</p></span>
</div>







<script type=text/javascript><!--//--><![CDATA[//><!--
function menuFix() {
 var sfEls = document.getElementById("nav").getElementsByTagName("li");
 for (var i=0; i<sfEls.length; i++) {
  sfEls[i].onmouseover=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseDown=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseUp=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onmouseout=function() {
  this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"), 
"");
  }
 }
}
window.onload=menuFix;
//--><!]]></script>
<script type="text/javascript">
var speed=9//�ٶ���ֵԽ���ٶ�Խ��
var demo=document.getElementById("demo");
var demo2=document.getElementById("demo2");
var demo1=document.getElementById("demo1");
demo2.innerHTML=demo1.innerHTML
function Marquee(){
if(demo2.offsetWidth-demo.scrollLeft<=0)
demo.scrollLeft-=demo1.offsetWidth
else{
demo.scrollLeft++
}
}
var MyMar=setInterval(Marquee,speed)
demo.onmouseover=function() {clearInterval(MyMar)}
demo.onmouseout=function() {MyMar=setInterval(Marquee,speed)}
</script>
<script type=text/javascript><!--//--><![CDATA[//><!--
function menuFix() {
 var sfEls = document.getElementById("nav").getElementsByTagName("li");
 for (var i=0; i<sfEls.length; i++) {
  sfEls[i].onmouseover=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseDown=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onMouseUp=function() {
  this.className+=(this.className.length>0? " ": "") + "sfhover";
  }
  sfEls[i].onmouseout=function() {
  this.className=this.className.replace(new RegExp("( ?|^)sfhover\\b"), 
"");
  }
 }
}
window.onload=menuFix;
//--><!]]></script>
</body>
</html>
