<!--
    ��Ӧ�̵�½�����ҳ�湫����ͷ��
    �ļ���header2.ascx
    �����������

-->

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">
            

        protected DataTable dt_yh = new DataTable(); //�û�����(�û���)    	
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie QQ_id = Request.Cookies["QQ_id"];
            if (QQ_id != null )
            {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            conn.Open();
            SqlDataAdapter da_yh = new SqlDataAdapter("select ���� from �û��� where QQ_id='"+QQ_id.Value+"'", conn);
            DataSet ds_yh = new DataSet();
            da_yh.Fill(ds_yh, "�û���");           
            dt_yh = ds_yh.Tables[0];
            }
		}	      
	


</script>

<div class="box">

    <div class="topx">
        <a href="gyszym.aspx">
            <img src="images/topx_02.jpg" /></a>
    </div>
    <div class="gyzy0">
        <div class="gyzy">
            �𾴵�
			<%foreach(System.Data.DataRow row in this.dt_yh.Rows){%>            
            <span><%=row["����"].ToString() %></span>           
            <%}%>
            ����/Ůʿ������
        </div>
    </div>
