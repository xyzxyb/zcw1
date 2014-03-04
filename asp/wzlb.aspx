<!--
        �����б�ҳ��
        �ļ�����wzlb.ascx
        ���������p     �б�ҳ��
                  id    ��������
               
    -->
<%@ Register Src="include/menu.ascx" TagName="Menu1" TagPrefix="uc1" %>
<%@ Register Src="include/pages.ascx" TagName="pages1" TagPrefix="uc2" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Text" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
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
    <title><%=Request["id"] %>�б�</title>
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



    <!-- ��ҳ �����б�ʼ-->


    <script runat="server">

        
        private const int Page_Size = 10; //ÿҳ�ļ�¼����
        private int current_page=1;
	    int pageCount_page;
        protected DataTable dt = new DataTable();
	    //protected DataTable dt1 = new DataTable();
        public class OptionItem
        {
            public string Text { get; set; }
            public string SelectedString { get; set; }
            public string Value { get; set; }      
       
        }
       	public List<OptionItem> Items { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {            

           //�Ӳ�ѯ�ַ����л�ȡ"ҳ��"����
            string strP = Request.QueryString["p"];
            if (string.IsNullOrEmpty(strP))
            {
                strP = "1";
            }

            int p;
            bool b1 = int.TryParse(strP, out p);
            if (b1 == false)
            {
                p = 1;
            }
            current_page = p;

            //�Ӳ�ѯ�ַ����л�ȡ"��ҳ��"����
            string strC = Request.QueryString["c"];
            if (string.IsNullOrEmpty(strC))
            {
                double recordCount = this.GetProductCount(); //134
                double d1 = recordCount / Page_Size; //13.4
                double d2 = Math.Ceiling(d1); //14.0
                int pageCount = (int)d2; //14
                strC = pageCount.ToString();
            }
            int c;
            bool b2 = int.TryParse(strC,out c);
            if (b2 == false)
            {
                c = 1;
            }
            pageCount_page = c;
            //����/��ѯ��ҳ����
            int begin = (p - 1) * Page_Size + 1;
            int end = p * Page_Size;
			String type = Request["id"];   //��ȡ���������ĵ����Ͳ���
            dt = this.GetProductFormDB(begin, end,type);
            this.SetNavLink(p, c);     
                  
        }
         

       
        protected string LinkPrev = "";
        protected string LinkNext = "";
        protected string LinkLast = "";       
        private void SetNavLink(int currentPage, int pageCount)
        {
          string path = Request.Path;
          var output = new StringBuilder();         
          if(currentPage>1)
           { 
             LinkPrev = currentPage != 1 ? string.Format("p={0}",currentPage - 1) : "";                          
           }
          if(currentPage<pageCount)
           {
            LinkNext = currentPage != pageCount ? string.Format("p={0}",
                currentPage + 1) : "";
           }
            LinkLast = currentPage != pageCount ? string.Format("p={0}",
                 pageCount) : "";  
  
           
           this.Items = new List<OptionItem>();
            for (int i = 1; i <= pageCount; i++)
            {
               
                OptionItem item = new OptionItem();
                item.Text = i.ToString();                          
                item.SelectedString =
                    i == currentPage ? "selected='selected'" : string.Empty;
                item.Value = string.Format("wzlb.aspx?p={0}",
               i);                
                this.Items.Add(item);
            }
      
        }
        DataConn objConn=new DataConn();
        private DataTable GetProductFormDB(int begin, int end ,string type)
        {
                     SqlParameter[] coll=
                     {
                     new SqlParameter("@begin",begin),
                     new SqlParameter("@end",end),
                     new SqlParameter("@�ĵ�����",type)                
                    }
                    dt=objConn.ExecuteProcForTable("wz_Paging",coll)

            return dt;
        }

        //�����ݿ��ȡ��¼��������
        private int GetProductCount()
        {
            
            string type = Request["id"];   //��ȡ���������ĵ����Ͳ���
            string sql = "select count(wz_Id) from ���±� where �ĵ�����='"+type+"' ";
          
                object obj = objConn.DBLook(sql);              
                int count = (int)obj;
                return count;        
        }
         
    </script>



    <div class="xw">
        <% string id=Request["id"];%>
        <div class="xw1"><a href="index.aspx" class="p1">��ҳ></a>&nbsp&nbsp&nbsp<%=id%></div>
        <div class="xw2">
            <dl>



                <% foreach(System.Data.DataRow row in dt.Rows){%>
                <dd><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>">��<%=row["����"].ToString() %></a></dd>
                <dt><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>"><%=row["����ʱ��"].ToString() %></a></dt>
                <% } %>
            </dl>

        </div>


        <!-- ��ҳ �����б� ����-->


        <!-- ҳ�뿪ʼ-->

        <div class="fy2">
            <div class="fy3">

                <% if(current_page!=1) { %>
                <a href="wzlb.aspx?<%=LinkPrev%>&id=<%=id%>" class="p">��һҳ</a>
                <% } %>
                <a href="wzlb.aspx?p=1&id=<%=id%>" class="p">1</a>
                <% if(pageCount_page>1) { %>
                <a href="wzlb.aspx?p=2&id=<%=id%>" class="p">2</a>
                <% } %>
                <% if(pageCount_page>2) { %>
                <a href="wzlb.aspx?p=3&id=<%=id%>" class="p">3������</a>
                <% } %>
                <% if(current_page<pageCount_page) { %>
                <a href="wzlb.aspx?<%=LinkNext %>&id=<%=id%>" class="p">��һҳ</a>
                <% } %>
                <% if(current_page!=pageCount_page) { %>
                <a href="wzlb.aspx?<%=LinkLast %>&id=<%=id%>" class="p">βҳ</a>
                <% } %>
ֱ�ӵ���  
    <select onchange="window.location=this.value" name="" class="p">
        <% foreach (var v in this.Items)
   { %>
        <option value="<%=v.Value %>&id=<%=id%>" <%=v.SelectedString %>><%=v.Text %></option>

        <%} %>
    </select>
                ҳ


            </div>
        </div>
    </div>

    <!-- ҳ�����-->




    <!-- �������� ������ Ͷ�߽��� ��ʼ-->
    <!-- #include file="static/aboutus.aspx" -->
    <!-- �������� ������ Ͷ�߽��� ����-->






    <!--  footer ��ʼ-->
    <!-- #include file="static/footer.aspx" -->
    <!-- footer ����-->



</body>
</html>
