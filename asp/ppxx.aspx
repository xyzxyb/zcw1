<!--
        Ʒ������ҳ��
        �ļ�����ppxx.ascx
        ���������pp_id    Ʒ�Ʊ��
               
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
    <title>Ʒ����Ϣҳ</title>
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

        protected DataTable dt_ppxx = new DataTable(); //Ʒ������(Ʒ���ֵ��)
		protected DataTable dt_scsxx = new DataTable(); //��Ӧ����Ϣ(���Ϲ�Ӧ����Ϣ��)
		protected DataTable dt_fxsxx = new DataTable(); //��������Ϣ(��Ӧ�̺ͷ�������ر�)
		protected DataTable dt_clxx = new DataTable(); //��Ʒ���µĲ�Ʒ(���ϱ�)
        DataConn objConn=new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {           
			string pp_id = Request["pp_id"];  //��ȡ��������pp_id
         dt_ppxx = objConn.GetDataTable("select Ʒ������,scs_id  from Ʒ���ֵ� where pp_id='"+pp_id+"'");
          
             //���ʼ�����1
            String str_updatecounter = "update Ʒ���ֵ� set ���ʼ��� = (select ���ʼ��� from Ʒ���ֵ� where pp_id = '"+ pp_id +"')+1 where pp_id = '"+ pp_id +"'";
            objConn.ExecuteSQL(str_updatecounter,false);
			
            dt_scsxx =objConn.GetDataTable("select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in (select scs_id from Ʒ���ֵ� where pp_id='"+pp_id+"' )");
          
			
            //��ø�Ʒ�Ƶķ�����Ϣ
			//string BrandsName=Request["BrandsName"];
           dt_fxsxx = objConn.GetDataTable("select ��Ӧ��,��ϵ��,��ϵ���ֻ�,��ϵ��ַ,gys_id from ���Ϲ�Ӧ����Ϣ�� where gys_id in ( select fxs_id from �����̺�Ʒ�ƶ�Ӧ��ϵ�� where pp_id='"+pp_id+"')");
           
			dt_clxx =  objConn.GetDataTable("select ��ʾ�� ,����ͺ�,cl_id from ���ϱ� where pp_id='"+pp_id+"'  ");         
        }	
       
    </script>

    <!-- ��ҳ Ʒ����Ϣ ��ʼ-->

    <div class="gysxx">
        <div class="gysxx1">
            <a href="index.aspx">��ҳ ></a>&nbsp&nbsp&nbsp
            <% foreach(System.Data.DataRow row in dt_ppxx.Rows){%>
            <a href="#"><%=row["Ʒ������"].ToString() %></a>
            <%}%>
        </div>
        <div class="gysxx2">
            <span class="gytu">
                <img src="images/133123_03.jpg" /></span>
            <div class="gycs">
                <% foreach(System.Data.DataRow row in dt_scsxx.Rows){%>
                <a href="gysxx.aspx?gys_id=<%=row["gys_id"] %>">
                <p>������<%=row["��Ӧ��"].ToString() %></p>
                <p>��ַ��<%=row["��ϵ��ַ"].ToString() %></p>
                <p>��ϵ�ˣ�<%=row["��ϵ��"].ToString() %></p>
                <p>�绰��<%=row["��ϵ���ֻ�"].ToString() %></p>
                </a>
                <%}%>
            </div>

        </div>

        <!-- ��ҳ Ʒ����Ϣ ����-->



        <!-- ��Ʒ�Ʒ����� ��ʼ-->

        <div class="gydl">
            <div class="dlpp">��Ʒ�Ʒ�����</div>
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
            <%foreach(System.Data.DataRow row in  dt_fxsxx.Rows){%>
            <a href="gysxx.aspx?gys_id=<%=row["gys_id"] %>">

            <div class="fxs2">
                <ul>

                    <li class="fxsa"><%=row["��Ӧ��"].ToString()%></li>
                    <li>�绰��<%=row["��ϵ���ֻ�"].ToString()%></li>
                    <li>��ϵ�ˣ�<%=row["��ϵ��"].ToString()%></li>
                    <li>��ַ��<%=row["��ϵ��ַ"].ToString()%></li>
                </ul>
            </div>
            </a>
            <%}%>
        </div>

        <!-- ��Ʒ�Ʒ����� ����-->


        <!-- ��Ʒ���²�Ʒ ��ʼ-->

        <div class="gydl">
            <div class="dlpp">��Ʒ���²�Ʒ</div>

            <%foreach(System.Data.DataRow row in dt_clxx.Rows){%>
            <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>">
            <div class="ppcp">
                <%					
                    String imgsrc= "images/222_03.jpg";
                 
                         Object result = objConn.DBLook("select  top 1 ��ŵ�ַ from ���϶�ý����Ϣ�� where cl_id ='"
                        +row["cl_id"]+"' and ��С='С'");
                         if (result != null) {
                             imgsrc = result.ToString();
                         }
                
                    Response.Write("<img src="+imgsrc+ " width=150px height=150px />");
                
				
				%>
                <span class="ppcp1"><%=row["��ʾ��"].ToString() %></span>
                <span class="ppcp2">���<%=row["����ͺ�"].ToString() %></span>
            </div>
            </a>
            <%}%>
        </div>
    </div>

    <!-- ��Ʒ���²�Ʒ ����-->

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
