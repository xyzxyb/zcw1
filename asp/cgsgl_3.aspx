<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Page language="C#" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ɹ�����Ϣҳ</title>
<link href="css/css.css" rel="stylesheet" type="text/css" />
<link href="css/all of.css" rel="stylesheet" type="text/css" />
</head>

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
<script runat="server">
	public userInfoObject userInfo;
	protected void Page_Load(object sender, EventArgs e){
	string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
  SqlConnection conn = new SqlConnection(constr);
  conn.Open();
  string yh_id ;
  //yh_id= Session["yh_id"].ToString();
  yh_id="20";
  string queryUserInfo = "select * from �û��� where yh_id='" + yh_id + "'";
  SqlDataAdapter da = new SqlDataAdapter(queryUserInfo, conn);
  DataSet ds = new DataSet();
  da.Fill(ds, "�û���");
  DataTable userInfoDS = new DataTable();
  userInfoDS = ds.Tables[0];
  if (userInfoDS.Rows.Count > 0){
  	DataRow dr2 = userInfoDS.Rows[0];   
    userInfo = new userInfoObject();
  //userInfo.companyname = Convert.ToString(userInfoDS["��ʾ��"]);
  //userInfo.companyaddress = Convert.ToString(userInfoDS["�������"]);
  //userInfo.companytel = Convert.ToString(userInfoDS["�ֻ�"]);
    userInfo.contactorname = Convert.ToString(dr2["����"]);
    userInfo.contactortel = Convert.ToString(dr2["�ֻ�"]);
  //userInfo.contactqqid = Session["qq_id"].ToString();
   // contactorname.Text = userInfo.contactorname;
   // contactortel.Text = userInfo.contactortel;
    conn.Close();
  }
}
  

  public class userInfoObject
  { //����
  	public string companyname { get; set; }
    public string companyaddress { get; set; }
    public string companytel { get; set; }
    public string contactortel { get; set; }
    public string contactorname { get; set; }
    public string contactqqid { get; set; }
    //public string Uid { get; set; }   
  }
</script>

<form runat="server">
	<script runat="server">
	protected void updateUserInfo(object sender, EventArgs e)
  {
  	string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
    SqlConnection conn = new SqlConnection(constr);
    conn.Open();
  	string yh_id;// = Session["yh_id"].ToString();
  	yh_id = Session["yh_id"].ToString();
  	//yh_id = "20";
  	
  //userInfo.companyname = Convert.ToString(userInfoDS["��ʾ��"]);
  //userInfo.companyaddress = Convert.ToString(userInfoDS["�������"]);
  //userInfo.companytel = Convert.ToString(userInfoDS["�ֻ�"]);
  	
  	string updateUserinfoString = " update �û��� " +
  	                              "    set �ֻ�='" + Request.Form["contactortel"]  + "', " +
  	                              "        ����='" + Request.Form["contactorname"] + "'  " + 
  	                              "  where yh_id='" + yh_id + "'" ;
  	SqlCommand cmd_updateUserinfo = new SqlCommand(updateUserinfoString, conn);         
    cmd_updateUserinfo.ExecuteNonQuery();
    //label1.Text=str_cancelfollow;
  	conn.Close();
  	//label1.Text = updateUserinfoString;
  	userInfo.contactorname =Request.Form["contactorname"];
    userInfo.contactortel =  Request.Form["contactortel"];
  }
	</script>
	
<div class="dlqq">
    <div class="dlex">
        <div class="dlex2">
            <span class="dlex3">������Ϣ���£���������뵥�����İ�ť</span>
            <dl>
							<dd>��˾���ƣ�</dd><dt><input name="companyname" type="text"  value="������������"/></dt>
							<dd>��˾��ַ��</dd><dt><input name="companyaddress" type="text"  value="������������"/></dt>
							<dd>��˾�绰��</dd><dt><input name="companytel" type="text"  value="������������"/></dt>
     					<dd>����������</dd><dt><input name="contactorname" value="<%= userInfo.contactorname %>"/></dt>
     					<dd>���ĵ绰��</dd><dt><input name="contactortel" value="<%= userInfo.contactortel %>" /></dt>
     					<dd>����QQ�ţ�</dd><dt><%=userInfo.contactqqid %></dt>
     					<dd>����ִ�գ�</dd><dt><img src="images/qqqq_03.jpg" /></dt>
     					<dd>�������ʣ�</dd><dt><img src="images/qqqq_03.jpg" /></dt>
            </dl>
            <asp:Label ID="label1" runat="server" Text="" />
            <span class="gg"><asp:ImageButton ID="updateButtion" ImageUrl="images/12ff_03.jpg"  OnClick="updateUserInfo" runat="server" /></span>
        </div>
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
