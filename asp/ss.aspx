<!--
           ����ҳ
           �ļ���Ϊ:ss.aspx
		   �������Ϊ: �����ı����е�ֵ
-->

<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

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
<title>�������ҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

<script runat="server">

          protected DataTable dt_clss = new DataTable();   //�����Ĳ�Ʒ(���ϱ�)   
          protected DataTable dt_cl_page = new DataTable();  //�������Ĳ��Ͻ��з�ҳ
		  protected DataTable dt_clss_name = new DataTable();  //��ѯ���в��Ϸ�����е���ʾ����,�������
		  
		  private const int Page_Size = 4; //ÿҳ�ļ�¼����
		  private int current_page=1;
	      int pageCount_page;

          public class OptionItem //���Ϸ�ҳ�� �� ����
          {
            public string Text { get; set; }
            public string SelectedString { get; set; }
            public string Value { get; set; }
          }
       	  public List<OptionItem> Items { get; set; }  //���Ϸ�ҳ����
          DataConn objConn=new DataConn();
          protected void Page_Load(object sender, EventArgs e)
          {
		     string key_ss = Request["sou"];  //��ȡ�����ı����е�ֵ
            
			 
			 dt_clss_name = objConn.GetDataTable("select  ��ʾ����,������� from ���Ϸ���� ");
          
			 foreach(System.Data.DataRow row in dt_clss_name.Rows)
			 {
			    //�ж��������Ϸ�����еķ���������ƥ����ת��һ�������ҳ��
			    if(key_ss==Convert.ToString(row["��ʾ����"])&Convert.ToString(row["�������"]).Length ==2)
				{
				   Response.Redirect("yjfl.aspx?name="+row["�������"].ToString()+" ");
				   return;
				}
			    if(key_ss==Convert.ToString(row["��ʾ����"])&Convert.ToString(row["�������"]).Length ==4)
				{
				   Response.Redirect("ejfl.aspx?name="+row["�������"].ToString()+" ");
				   return;
				}
			 }
			 
             dt_clss= objConn.GetDataTable("select top 10 ��ʾ��,����ͺ�,cl_id ,���ʼ��� from ���ϱ� where ��ʾ�� like '%"+key_ss+"%'order by ���ʼ��� desc");
         


             //�Ӳ�ѯ�ַ����л�ȡ"ҳ��"����
            string str_page = Request.QueryString["p"];
            if (string.IsNullOrEmpty(str_page))
            {//Ϊ��ʱĬ��Ϊ1
                str_page = "1";
            }
            int p;
            bool b1 = int.TryParse(str_page, out p);  //У�� ��ַ����Ϊ���� ��ǿתΪ����
            if (b1 == false)
            {
                p = 1;
            }
            current_page = p;
			
            //�Ӳ�ѯ�ַ����л�ȡ"��ҳ��"����
            string str_Count = Request.QueryString["c"];
            if (string.IsNullOrEmpty(str_Count))
            {
                double recordCount = this.GetProductCount(); //���������
                double d1 = recordCount / Page_Size; //13.4
                double d2 = Math.Ceiling(d1); //14.0
                int pageCount = (int)d2; //14                //ȡ��
                str_Count = pageCount.ToString();
            }
            int c;
            bool b2 = int.TryParse(str_Count,out c);
            if (b2 == false)
            {
                c = 1;
            }
            pageCount_page = c;
			
            //����/��ѯ��ҳ����
            int begin = (p - 1) * Page_Size + 1;    //��ʼ��¼�� ����ڶ�ҳʱ(��ÿҳ10) begin Ϊ11��
            int end = p * Page_Size;                //�����ļ�¼��
            dt_cl_page = this.GetProductFormDB(begin, end,key_ss);
            this.SetNavLink(p, c); 	

          }
              //�����ݿ��ȡ��¼��������
              private int GetProductCount()
              {
                   
                    string key_ss = Request["sou"];  //��ȡ�����ı����е�ֵ
                    string sql = "select count(cl_Id) from ���ϱ� where ��ʾ�� like '%"+key_ss+"%'";
                      object obj = objConn.DBLook(sql);
                      int count = (int)obj;
                      return count;
              }

              private DataTable GetProductFormDB(int begin, int end, string key_ss)
              {
                                 SqlParameter[] coll=
                     {
                     new SqlParameter("@begin",begin),
                     new SqlParameter("@end",end),
                     new SqlParameter("@��ʾ��",key_ss)
                    
                   //  cmd.Parameters.Add("@begin", SqlDbType.Int).Value = begin;            //��ʼҳ��һ����¼
                    // cmd.Parameters.Add("@end", SqlDbType.Int).Value = end;                //��ʼҳ���һ����¼
			        // cmd.Parameters.Add("@��ʾ��", SqlDbType.VarChar,20).Value = key_ss; //�����ϱ�������ϱ�,ִ�д洢����
                    }
                    dt_cl_page=objConn.ExecuteProcForTable("cl_ss_Paging",coll)
                    // SqlDataAdapter sda = new SqlDataAdapter(cmd);        

                     return dt_cl_page;
        
               }

               protected string cpPrev = "";
               protected string cpNext = "";
               protected string cpLast = "";       
               private void SetNavLink(int currentPage, int pageCount)
               {
                   //string path = Request.Path;         
                   cpPrev = currentPage != 1 ? string.Format("p={0}",currentPage - 1) : "";          //����������һҳ
                   cpNext = currentPage != pageCount ? string.Format("p={0}",currentPage + 1) : "";  //����������һҳ
                   cpLast = currentPage != pageCount ? string.Format("p={0}",pageCount) : "";         //��������βҳ
           
                   this.Items = new List<OptionItem>();
                   for (int i = 1; i <= pageCount; i++)  //�����б�ѭ���ܵ�ҳ��
                   {               
                       OptionItem item = new OptionItem();
                       item.Text = i.ToString();                          
                       item.SelectedString = i == currentPage ? "selected='selected'" : string.Empty;
                       item.Value = string.Format("ss.aspx?p={0}", i);                
                       this.Items.Add(item);
                   }
      
               }			   
        
         
		  
		  
		  

</script>

<body>

<!-- ͷ����ʼ-->
<!-- #include file="static/header.aspx" -->
<!-- ͷ������-->


<!-- ������ʼ-->
<uc1:Menu1 ID="Menu1" runat="server" />
<!-- ��������-->


<!-- banner��ʼ-->
<!-- #include file="static/banner.aspx" -->
<!-- banner ����-->



<div class="sc">

<div class="xzss">
<div class="ppxz">
<div class="ppxz1">Ʒ�ƣ�</div><div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> <a href="#">Ʒ��1</a> <a href="#">Ʒ��2</a> <a href="#">Ʒ��3</a></div></div>
<div class="ppxz">
<div class="ppxz1">����</div><div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> <a href="#">������</a> <a href="#">������</a> <a href="#">��̨��</a></div></div>
<div class="ppxz">
<div class="ppxz1">���ϣ�</div><div class="ppxz2"><a href="#"><img src="images/qwez.jpg" /></a> <a href="#">����1</a> <a href="#">����2</a> <a href="#">����3</a></div></div>
<div class="ppxz">
<div class="ppxz1">���ࣺ</div><div class="ppxz2"></a> <a href="#">����1</a> <a href="#">����2</a> <a href="#">����3</a></div></div>

<div class="dlspx"><span class="dlspx1">����</span><span class="dlspx2"><a href="#">Ĭ��</a></span><span class="dlspx3"><a href="#">����</a><img src="images/qweqw_03.jpg" /></span>
<span class="dlspx3"><a href="#">����</a><img src="images/qweqw_03.jpg" /></span> <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /><a href="#">ȫѡ</a></span>
<span class="dlspx4"><a href="#">���ղأ����ڲ���</a></span>
</div>
</div>


<div class="dlspxl"> 

    <%foreach(System.Data.DataRow row in this.dt_cl_page.Rows){%>
    <div class="dlspxt">
    <a href="clxx.aspx?cl_id=<%=row["cl_id"]%>">
     <%
				
                    String imgsrc= "images/222_03.jpg";

                         Object result = objConn.DBLook("select  top 1 ��ŵ�ַ from ���϶�ý����Ϣ�� where cl_id ='"
                        +row["cl_id"]+"' and ��С='С'");
                         if (result != null) 
						 {
                             imgsrc = result.ToString();
                         }
                   
                    Response.Write("<img src="+imgsrc+ " width=150px height=150px />");
                
				
				%>
    </a>
    <div class="dlspxt1">
    <span class="dlsl"><%=row["��ʾ��"].ToString()%></span>  
    <span class="dlspx3"><input name="" type="checkbox" value=""  class="fxk" /> �ղ�</span> 
    <span class="dlsgg"><%=row["����ͺ�"].ToString()%></span> </div></div>
  <%}%>





<div class="fy2">
<div class="fy3">
                <%string key_ss = Request["sou"];  //��ȡ�����ı����е�ֵ %>
                <% if(current_page!=1) { %>
                <a href="ss.aspx?<%=cpPrev %>&sou=<%=key_ss%>" class="p">��һҳ</a>
                <% } %>
                <a href="ss.aspx?p=1&sou=<%=key_ss%>" class="p">1</a>
                <% if(current_page>1) { %>
                <a href="ss.aspx?p=2&sou=<%=key_ss%>" class="p">2</a>
                <% } %>
                <% if(current_page>2) { %>
                <a href="ss.aspx?p=3&sou=<%=key_ss%>" class="p">3������</a>
                <% } %>
                <% if(current_page<pageCount_page) { %>
                <a href="ss.aspx?<%=cpNext %>&sou=<%=key_ss%>" class="p">��һҳ</a>
                <% } %>
                <% if(current_page!=pageCount_page) { %>
                <a href="ss.aspx?<%=cpLast %>&sou=<%=key_ss%>" class="p">βҳ</a>
                <% } %>
				
ֱ�ӵ��� 
         <select onchange="window.location=this.value" name="" class="p">
         <% foreach (var v in this.Items)  { %>
         <option value="<%=v.Value %>&sou=<%=key_ss%>" <%=v.SelectedString %>><%=v.Text %></option>

        <%} %>
    </select>     
ҳ</div></div>
</div>


<!-- ���ܻ�ӭ�����ֲ���-->
<div class="pxright0">
<div class="pxright">
<div class="pxright1">
<ul>

   <%foreach(System.Data.DataRow row in this.dt_clss.Rows){%>
   <li><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>"><%=row["��ʾ��"].ToString()%></a></li>
   <%}%>

</ul>

</div> </div>
<div class="pxright2"><a href="#"><img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a></div>
</div>


</div>



<div>
<!-- �������� ������ Ͷ�߽��� ��ʼ-->
<!-- #include file="static/aboutus.aspx" -->
<!-- �������� ������ Ͷ�߽��� ����-->
</div>

<!--  footer ��ʼ-->
<!-- #include file="static/footer.aspx" -->
<!-- footer ����-->




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
