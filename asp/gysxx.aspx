<!--
        ��Ӧ����Ϣҳ��
        �ļ�����gysxx.ascx
        ���������gys_id    ��Ӧ�̱��
               
    -->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=8ee0deb4c10c8fb4be0ac652f83e8f5d"></script>
    <title>���Ϲ�Ӧ����Ϣ</title>
    <link href="css/css.css" rel="stylesheet" type="text/css" />
    <link href="css/all of.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
	#allmap {width:400px;height:300px;border:#ccc solid 1px;}
</style>
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

        protected DataTable dt_fxsxx = new DataTable();  //��Ӧ����Ϣ����(���Ϲ�Ӧ����Ϣ��)
		protected DataTable dt_gysxx = new DataTable(); //��Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��)
		protected DataTable dt_ppxx = new DataTable(); //����Ʒ��(Ʒ���ֵ�)
		protected DataTable dt_clxx = new DataTable(); //�ֻ���Ӧ(���ϱ�)
        protected String gys_id;
        protected String gys_type;
		protected String gys_addr;


        protected void Page_Load(object sender, EventArgs e)
        {
		    if (!Page.IsPostBack)
            {
                string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                SqlConnection conn = new SqlConnection(constr);
                conn.Open();
			    gys_id = Request["gys_id"];   //��ȡ��Ӧ��id
                       
			
			    SqlDataAdapter da_gysxx = new SqlDataAdapter("select ��Ӧ��,��λ����,��ϵ��,��ϵ���ֻ�,��ϵ��ַ from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+gys_id+"'", conn);
                DataSet ds_gysxx = new DataSet();
                da_gysxx.Fill(ds_gysxx, "���Ϲ�Ӧ����Ϣ��");            
                dt_gysxx = ds_gysxx.Tables[0];

                //���ʼ�����1
                String str_updatecounter = "update ���Ϲ�Ӧ����Ϣ�� set ���ʼ��� = (select ���ʼ��� from ���Ϲ�Ӧ����Ϣ�� where gys_id = '"+ gys_id +"')+1 where gys_id = '"+ gys_id +"'";
                SqlCommand cmd_updatecounter = new SqlCommand(str_updatecounter, conn);         
                cmd_updatecounter.ExecuteNonQuery();

                //��ù�Ӧ�̵ĵ�λ���ͣ������̻��Ƿ�����
                gys_type = Convert.ToString(dt_gysxx.Rows[0]["��λ����"]);
			
                
                //������Ϊ����Ʒ�ƺ��������۲���
                if (gys_type.Equals("������")) 
                {
                    //��ô���Ʒ����Ϣ
			        SqlDataAdapter da_ppxx = new SqlDataAdapter("select Ʒ������,pp_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where fxs_id='"+gys_id+"'", conn);
                    DataSet ds_ppxx = new DataSet();
                    da_ppxx.Fill(ds_ppxx, "�����̺�Ʒ�ƶ�Ӧ��ϵ��");            
                    dt_ppxx = ds_ppxx.Tables[0];
			
                    //������ڷ����Ĳ����б�
			        SqlDataAdapter da_clxx = new SqlDataAdapter("select ��ʾ��,cl_id from ���ϱ� where pp_id in(select pp_id from  �����̺�Ʒ�ƶ�Ӧ��ϵ�� where fxs_id ='"+gys_id+"') ", conn);
                    DataSet ds_clxx = new DataSet();
                    da_clxx.Fill(ds_clxx, "���ϱ�");            
                    dt_clxx = ds_clxx.Tables[0];
                }
                else  //����������ʾ����Ʒ�ƺ����ķ�����
                {
                     //��ȡƷ����Ϣ
			        SqlDataAdapter da_ppxx = new SqlDataAdapter("select Ʒ������,pp_id from Ʒ���ֵ� where �Ƿ����� = '1' and scs_id='"+gys_id+"'", conn);
                    DataSet ds_ppxx = new DataSet();
                    da_ppxx.Fill(ds_ppxx, "Ʒ���ֵ�");            
                    dt_ppxx = ds_ppxx.Tables[0];
			
                    //��ȡ��������Ϣ
			        //�Ӳ�ѯǶ�� �ȸ��ݴ�������gys_id��Ʒ������  �ٴ�Ʒ���ֵ���鸴��������gys_id �����ݸ���������gys_id���������Ϣ
			        SqlDataAdapter da_fxsxx = new SqlDataAdapter("select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in(select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id in(select pp_id from Ʒ���ֵ� where scs_id='"+gys_id+"') )", conn);
                    DataSet ds_fxsxx = new DataSet();
                    da_fxsxx.Fill(ds_fxsxx, "���Ϲ�Ӧ����Ϣ��");            
                    dt_fxsxx = ds_fxsxx.Tables[0];
                }
                conn.Close();
			
			
         }		
        }
    </script>



    <!-- ��ҳ ��Ӧ����Ϣ ��ʼ-->

    <div class="gysxx">
        <div class="gysxx1">
            <a href="index.aspx">��ҳ ></a>&nbsp&nbsp 
            <% foreach(System.Data.DataRow row in dt_gysxx.Rows){%>
            <a href="#"><%=row["��Ӧ��"].ToString() %></a>
            <%}%>
        </div>
        <div class="gysxx2">
            <span class="gytu">
                <img src="images/133123_03.jpg" /></span>
            <div class="gycs">

                <% foreach(System.Data.DataRow row in dt_gysxx.Rows){
				   gys_addr = row["��ϵ��ַ"].ToString();%>
                <p>������<%=row["��Ӧ��"].ToString() %></p>
                <p>��ַ��<%=gys_addr %></p>
                <p>��ϵ�ˣ�<%=row["��ϵ��"].ToString() %></p>
                <p>��ϵ�绰��<%=row["��ϵ���ֻ�"].ToString() %></p>
                <%}%>
            </div>
            <div class="gyan"><a href="#">������δ���죬������ǵ����������챾�꣬����֮�����ά�������Ϣ</a></div>
            <div class="gyan1"><a href="" onclick="NewWindow(<%=gys_id %>)">���ղأ����ڲ���</a></div>
        </div>
		
		<div class="gydl">
            <div class="dlpp">����λ��</div>
			<div id="allmap"></div>
<script type="text/javascript">

// �ٶȵ�ͼAPI����
var map = new BMap.Map("allmap");
var point = new BMap.Point(116.331398,39.897445);
map.centerAndZoom(point,15);
// ������ַ������ʵ��
var myGeo = new BMap.Geocoder();
// ����ַ���������ʾ�ڵ�ͼ��,��������ͼ��Ұ
myGeo.getPoint("<%=gys_addr %>", function(point){
  if (point) {
    map.centerAndZoom(point, 13);
    map.addOverlay(new BMap.Marker(point));
  }
}, "<%=gys_addr %>");
</script>
                    
            
        </div>
		
        <!-- ��ҳ ��Ӧ����Ϣ ����-->

        <% if (gys_type.Equals("������")) 
           {
        %>

        <!-- ����Ʒ�� ��ʼ-->

        <div class="gydl">
            <div class="dlpp">����Ʒ��</div>
            <%foreach(System.Data.DataRow row in dt_ppxx.Rows)
              {%>
                    <a href="ppxx.aspx?pp_id=<%=row["pp_id"] %>">
                    <div class="gydl1">
                        <img src="images/222_03.jpg" /><%=row["Ʒ������"].ToString()%>

                    </div>
                    </a>
            <%}%>
        </div>

        <!-- ����Ʒ�� ����-->


        <!-- �ֻ���Ӧ ��ʼ-->

        <div class="gydl">
            <div class="dlpp">�ֻ���Ӧ</div>

            <%foreach(System.Data.DataRow row in dt_clxx.Rows){%>
            <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>">			
			
			

            <div class="gydl1">
			<%
					string connString = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection con = new SqlConnection(connString);
                    SqlCommand cmd = new SqlCommand("select  top 1 ��ŵ�ַ from ���϶�ý����Ϣ�� where cl_id ='"
                        +row["cl_id"]+"' and ��С='С'", con);

                    String imgsrc= "images/222_03.jpg";
                    using (con)
                    {
                         con.Open();
                         Object result = cmd.ExecuteScalar();
                         if (result != null) {
                             imgsrc = result.ToString();
                         }
                    }
                    Response.Write("<img src="+imgsrc+ " width=150px height=150px />");
                
				
				%>
                
				<%=row["��ʾ��"].ToString() %>
			</div>
            </a>
            <%}%>
        </div>

        <% }else { %>
              
            <!-- ��˾����Ʒ�� ��ʼ-->

            <div class="gydl">
            <div class="dlpp">��˾����Ʒ��</div>
            <%foreach(System.Data.DataRow row in dt_ppxx.Rows){%>
            <a href="ppxx.aspx?pp_id=<%=row["pp_id"] %>">

            <div class="gydl1">
                <img src="images/222_03.jpg" /><%=row["Ʒ������"].ToString()%></div>
            </a>
            <%}%>
         </div>

        <!-- ��˾����Ʒ�� ����-->

        <!-- ������ҳ ��ʼ-->

        <div class="gydl">
            <div class="dlpp">������</div>
            <div class="fxs1">
                <select name="" class="fu1">
                    <option>����</option>
                </select>
                <select name="" class="fu2">
                    <option>����</option>
                </select>ʡ���У�
    <select name="" class="fu3">
        <option>ʯ��ׯ</option>
    </select>
                ����<select name="" class="fu4"><option>����</option>
                </select>
                �����أ�
            </div>

            <%foreach(System.Data.DataRow row in dt_fxsxx.Rows){%>
            <a href="gysxx.aspx?gys_id=<%=row["gys_id"] %>">

            <div class="fxs2">
                <ul>
                    <li class="fxsa"><%=row["��Ӧ��"].ToString() %></li>
                    <li>��ϵ�ˣ�<%=row["��ϵ��"].ToString() %></li>
                    <li>�绰��<%=row["��ϵ���ֻ�"].ToString() %></li>
                    <li>��ַ��<%=row["��ϵ��ַ"].ToString() %></li>
                </ul>
            </div>
                </a>
            <%}%>
        </div>

           <% }
            %>

    </div>

    <!-- �ֻ���Ӧ ����-->

    <div>
        <!-- �������� ������ Ͷ�߽��� ��ʼ-->
        <!-- #include file="static/aboutus.aspx" -->
        <!-- �������� ������ Ͷ�߽��� ����-->
    </div>

    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->

    
    <script>function NewWindow(id) {
    var url = "scgys.aspx?gys_id=" + id;
    window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
}
</script>
</body>
</html>
