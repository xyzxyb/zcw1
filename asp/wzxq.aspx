<!--
        ��������ҳ��
        �ļ�����wzxq.ascx
        ���������p     �б�ҳ��
                  wz_id    ��������
               
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
    <title>��������ҳ</title>
    <style type="text/css">
        .p {
            font-size: 12px;
            color: Black;
            font-weight: bold;
            text-decoration: none;
        }

        .p1 {
            font-size: 15px;
            color: blue;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
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



    <!-- ������ҳ ��ʼ-->
    <script runat="server">
                         
 	    protected DataTable dt=new DataTable();  //���±�
        protected DataTable dt1=new DataTable();  //���º�������ر�
        protected DataTable dt2=new DataTable();  //���ºͳ�����ر�
        protected DataTable dt3=new DataTable();  //���ºͲ�Ʒ��ر�
        protected int total_pages =1;
        protected int current_page = 1;
        protected string wz_id;
        DataConn objConn=new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {
            
            wz_id=Request["wz_id"];  //��ȡ����id
           dt = objConn.GetDataTable("select distinct ����,����, wz_id from ���±� where wz_id='"+wz_id+"'");            
            dt2 = objConn.GetDataTable("select ��������,gys_id from ���ºͳ�����ر� where wz_id='"+wz_id+"'");          
            dt3 =objConn.GetDataTable("select ��Ʒ����,cl_id from ���ºͲ��ϱ���ر� where wz_id='"+wz_id+"' ");           
          

            string page = Request["p"];
            if (page != null) current_page = int.Parse(page);   
                    
            string strr="select ҳ������, ҳ����, wz_id from ���º�������ر� where wz_id='"+wz_id+"' and ҳ����='"+ current_page+"'";  
            dt1 = objConn.GetDataTable(strr);

            string total_sql_str = "select count(*) from ���º�������ر� where wz_id='"+wz_id+"'";
           
            Object result = objConn.DBLook(total_sql_str);
            if (result != null) 
            {
                total_pages = int.Parse(Convert.ToString(result));
            }             
        
        }
			
			

    </script>



    <div class="xwn">
        <div class="xwn1"><a href="index.aspx" class="p1">��ҳ ></a>����</div>
        <div class="xwleft">

            <% foreach(System.Data.DataRow row in dt.Rows){%>
            <div class="xwleft1"><%=row["����"].ToString() %></div>
            <div class="xwleft2">���ߣ�<%=row["����"].ToString() %></div>

            <% foreach(System.Data.DataRow row2 in dt1.Rows){%>
            <div class="xwleft3"><%=row2["ҳ������"].ToString() %></div>
            <%}%>
          
            <center>
        <div>
            <div class="fy3">
                <% if(total_pages >1 && current_page !=1) { %>
                <a href="wzxq.aspx?wz_id=<%=wz_id %>&p=<%=current_page-1%>" class="p">��һҳ</a>
                <% } %>
              
                <% if(current_page<total_pages ) { %>
                <a href="wzxq.aspx?wz_id=<%=wz_id %>&p=<%=current_page+1%>" class="p">��һҳ</a>
                <% } %>

              </div>
               
          </div>
    </center>
            <%}%>
        </div>

        <!-- ������ҳ ����-->





        <div class="xwright">
            <!-- ��س����б� ��ʼ-->
            <% if (dt2.Rows != null & dt2.Rows.Count >0 ) {  %>
                
            <div class="xwright1">
                <ul>
                    <%foreach(System.Data.DataRow row in dt2.Rows){%>
                    <li><a href="gysxx.aspx?gys_id=<%=row["gys_id"]%>"><%=row["��������"].ToString()%></a></li>
                    <%}%>
                </ul>
            </div>
            <% } %>
            <!-- ��س����б� ����-->



            <!-- ��ز�Ʒ�б� ��ʼ-->
             <% if (dt3.Rows != null & dt3.Rows.Count >0 ) {  %>
            <div class="xwright1">
                <ul>
                    <%foreach(System.Data.DataRow row in dt3.Rows){%>
                    <li><a href="clxx.aspx?cl_id=<% =row["cl_id"]%>"><%=row["��Ʒ����"].ToString()%></a></li>
                    <%}%>
                </ul>
            </div>
            <% } %>
            <!-- ��ز�Ʒ�б� ����-->


        </div>

    </div>


    <!-- ����ҳ�뿪ʼ -->
    
 
    <!-- ����ҳ����� -->



    <!-- �������� ������ ��ʼ-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- �������� ������ ����-->



    <!-- footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->

   
    <body>
</html>
