<!--
          
       ��Ӧ����������ҳ��	   
       �ļ�����czclym.aspx 
       �������:��	 (Ӧ��Ҫ���빩Ӧ��id)  
	   
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
    <title>��������ҳ��</title>
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
	
	
       //�������෢��ajax ���µ���Ʒ�Ƶ����� �Ͳ������Ե�����
	   //�ļ�����xzclym3.aspx �� xzclymSX.aspx
      function updateCLFL(id) 
	{

        var xmlhttp;
		var xmlhttp1;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
			xmlhttp1 = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			 xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                
                document.getElementById("brand").innerHTML = xmlhttp.responseText;
			
            }
        }
        xmlhttp.open("GET", "xzclym3.aspx?id=" + id, true);
        xmlhttp.send();
		
		
        xmlhttp1.open("GET", "xzclymSX.aspx?id=" + id, true);
        xmlhttp1.send();
		xmlhttp1.onreadystatechange = function () {
            
            if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
                
               	//document.getElementById("sx_name").innerHTML = xmlhttp1.responseText;				
		
				
				var array = new Array();           //��������
		 		array = xmlhttp1.responseText;     //���շ��ص�json�ַ���
				
		        var json = array;
                var myobj=eval(json);              //�����ص�JSON�ַ���ת��JavaScript���� 
				
				
				
                for(var i=0;i<myobj.length;i++){  //����			
			
				 var json= document.getElementById('sx_names');
                 json.options.add(new Option(myobj[i].SX_name, myobj[i].SX_id));  //��������ʾ��������

                 var json_code= document.getElementById('sx_codes');     //��������ʾ���Ա���
                 json_code.options.add(new Option(myobj[i].SX_code,myobj[i].SX_code));	

                 var json_id= document.getElementById('sx_id');       //��������ʾ����id
                 json_id.options.add(new Option(myobj[i].SX_id,myobj[i].SX_id));				 
				
               
                }       
		
              } 	

           }
        }
              
    
	
	
	//��������ajax ���µ�������ֵ �ļ�����:xzclymSX2.aspx
	//���µ��ǹ���ͺ� �ļ�����:xzclymSX3.aspx  (����ͺ�Ӧ�����ı���ź���)
    function update_clsx(id) 
	{
	    
        var xmlhttp1;
        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
			xmlhttp1 = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
        }
        
        xmlhttp.open("GET", "xzclymSX2.aspx?id=" + id, true);
        xmlhttp.send();
		xmlhttp.onreadystatechange = function () {
            
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                
                //document.getElementById("cl_value").innerHTML = xmlhttp.responseText;
				
				var array = new Array();           //��������
		 		array = xmlhttp.responseText;     //�����滻���ص�json�ַ���
				
		        var json = array;
                var myobj=eval(json);              //�����ص�JSON�ַ���ת��JavaScript���� 			
				
				
                for(var i=0;i<myobj.length;i++){  //����			
			
				 var json= document.getElementById('cl_value');
                 json.options.add(new Option(myobj[i].SXZ_name,myobj[i].SXZ_name));  //��������ʾ����ֵ

                 var json_code= document.getElementById('cl_number');     //��������ʾ���Ա��
                 json_code.options.add(new Option(myobj[i].SXZ_code,myobj[i].SXZ_code));	

                 var json_id= document.getElementById('cl_ids');       //��������ʾ����ֵid
                 json_id.options.add(new Option(myobj[i].SXZ_id,myobj[i].SXZ_id));				 
				
               
                }  
            }
        }
		
		 xmlhttp1.open("GET", "xzclymSX3.aspx?id=" + id, true);
        xmlhttp1.send();
		xmlhttp1.onreadystatechange = function () {
            
            if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
                
				var ggxh_value = xmlhttp1.responseText;
				
               	document.getElementById("cl_type").value = ggxh_value;
            }
        }
              
    }
            
		

			

</script>


<script runat="server">  
        
    public List<OptionItem> Items1 { get; set; }    
    public class OptionItem
    {
        public string Name { get; set; }  //�����б���ʾ������
        public string GroupsCode { get; set; }  //�����б�����������
      

    }
    protected DataTable dt_clfl = new DataTable();  //���Ϸ������    
    
    protected void Page_Load(object sender, EventArgs e)
    {
        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
        SqlConnection conn = new SqlConnection(constr);
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

    }				
 
</script>

<body>

    <!-- ͷ����ʼ-->
    <uc2:Header2 ID="Header2" runat="server" />
    <!-- ͷ������-->


    <div class="fxsxx">
        <span class="fxsxx1">��ѡ����Ҫ��ӵĲ�����Ϣ</span>
        <%string gys_id = Request["gys_id"];%>
          <form action="xzclym4.aspx?gys_id=134" method="post" >

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
                    <span class="xzz0">���û���ʺϵ�С�࣬����ϵ��վ����Ա���ӣ� ��ϵ��ʽ��xxx@xxx.com.��ʹ��ģ�塣 </span>
                    <span class="xzz1"><a href="#">ģ�����ص�ַ</a></span>
                </div>
            </div>

            <div class="fxsxx2">
                <span class="srcl">�����������Ϣ</span>
                <dl>
                    <dd>�������֣�</dd>
                    <dt>
                        <input name="cl_name" type="text" class="fxsxx3" value="<%=Request.Form["cl_name"] %>" /></dt>

                    <dd>Ʒ    �ƣ�</dd>
                    <dt>
                        <select name="brand" id="brand" style="width: 300px">
                            
                            <option value="0">��ѡ��Ʒ��</option>
                           
                        </select></dt>

                    <dd>�������ƣ�</dd>
                    <dt>
                        <select name="sx_names" id="sx_names" style="width: 300px" onchange="update_clsx(this.options[this.options.selectedIndex].value)">
                                                                       
                            <option value="0">��ѡ����������</option>
						
                        </select></dt>
						
						<dd>���Ա��룺</dd>
                    <dt>
                        <select name="sx_codes" id="sx_codes" style="width: 300px" >
                                                                       
                            <option value="0">��ѡ�����Ա���</option>
						
                        </select></dt>
						
						<dd>����id��</dd>
                    <dt>
                        <select name="sx_id" id="sx_id" style="width: 300px" >
                                                                       
                            <option value="0">����id</option>
						
                        </select></dt>
						
						
                    <dd>����ֵ��</dd>
                    <dt>
                        <select name="cl_value" id="cl_value" style="width: 300px"  >
                            
                            <option value="0">��ѡ������ֵ</option>
                           
                        </select></dt>
						
					<dd>����ֵ��ţ�</dd>
                    <dt>
                        <select name="cl_number" id="cl_number" style="width: 300px"  >
                            
                            <option value="0">���</option>
                           
                        </select></dt>
						
					<dd>����ֵID�ţ�</dd>
                    <dt>
                        <select name="cl_ids" id="cl_ids" style="width: 300px"  >
                            
                            <option value="0">����ֵid</option>
                           
                        </select></dt>
						
					<dd>����ͺţ�</dd>                    
                    <dt>
                        <input name="cl_type" type="text" id="cl_type" class="fxsxx3" value="<%=Request.Form["cl_type"] %>" /></dt>					
						
                    <dd>������λ��</dd>
                    <dt>
                        <input name="cl_bit" type="text" class="fxsxx3" value="<%=Request.Form["cl_bit"] %>" /></dt>
                    <dd>��λ�����</dd>
                    <dt>
                        <input name="cl_volumetric" type="text" class="fxsxx3" value="<%=Request.Form["cl_volumetric"] %>" /></dt>
				    <dd>��λ������</dd>
                    <dt>
                        <input name="cl_height" type="text" class="fxsxx3" value="<%=Request.Form["cl_height"] %>" /></dt>
                    <dd>˵����</dd>
                    <dt>
                        <input name="cl_instruction" type="text" class="fxsxx3" value="<%=Request.Form["instruction"] %>" /></dt>
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
                    <dt>
                        <input name="" type="text" class="fxsxx3" /><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
                    <dd>�ɹ�������</dd>
                    <dt>
                        <input name="" type="text" class="fxsxx3" /><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
                    <dd>�������ϣ�</dd>
                    <dt>
                        <input name="" type="text" class="fxsxx3" /><a href="#"><img src="images/qweqwe_03.jpg" /></a></dt>
                </dl>

                <span class="fxsbc"><a href="#">
                    <input type="image" name="Submit" value="Submit" src="images/bbc_03.jpg"></a></span>

            </div>
        </form>
    </div>
 

    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->

</body>
</html>
