<!--
        ����һ�������б�ҳ��
        �ļ�����yjfl.ascx
        ���������name
               
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
    <style type="text/css">
        .p {
            font-size: 12px;
            color: Black;
            font-weight: bold;
            text-decoration: none;
        }

        .p1 {
            font-size: 16px;
            color: blue;
            font-weight: bold;
            text-decoration: none;
        }
    </style>

    <title>һ������</title>
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



    <!-- ��ҳ ʯ����ҳ ��ʼ-->

    <script runat="server">
        protected DataTable dt = new DataTable();   //������������
        protected DataTable dt1 = new DataTable();  //�������Ʒ�ҳ (�����µ����в��Ϸ�ҳ)
        protected DataTable dt2 = new DataTable();  //��ҳ��ʾһ����������
        protected DataTable dt3 = new DataTable();   //����������� ���������ʯ��	
		protected DataTable dt_wz = new DataTable();  //�����ѡ����ʯ���������(���±�)
        		
        private const int Page_Size = 20; //ÿҳ�ļ�¼����
		private int current_page=1;
	    int pageCount_page;

        public class OptionItem
        {
            public string Text { get; set; }
            public string SelectedString { get; set; }
            public string Value { get; set; }
        }
       	public List<OptionItem> Items { get; set; }
        DataConn objConn=new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {
           
            string name= Request["name"]; //��ȡ��ҳ��������һ���������(��λ)
            dt = objConn.GetDataTable("select top 10 ��ʾ����,������� from ���Ϸ���� where  left(�������,2)='"+name+"' and len(�������)='4' ");            
          

           dt2 =  objConn.GetDataTable("select  ��ʾ����,fl_id from ���Ϸ���� where  �������='"+name+"' ");                
			
            dt3 =  objConn.GetDataTable("select distinct top 10 ��ʾ��,cl_id from ���ϱ� where left(���ϱ���,2)='"+name+"' ");             
			
			dt_wz = objConn.GetDataTable("select top 4 ����,ժҪ,wz_id from ���±� where left(�������,2)='"+name+"' ");
			
            
			

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
                double recordCount = this.GetProductCount(); //������
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
            dt1 = this.GetProductFormDB(begin, end,name);
            this.SetNavLink(p, c);   
            		
        }
      
        protected string cpPrev = "";
        protected string cpNext = "";
        protected string cpLast = "";       
        private void SetNavLink(int currentPage, int pageCount)
        {
            string path = Request.Path;         
            cpPrev = currentPage != 1 ? string.Format("p={0}", //����������һҳ
                 currentPage - 1) : "";
            cpNext = currentPage != pageCount ? string.Format("p={0}", //����������һҳ
                currentPage + 1) : "";
            cpLast = currentPage != pageCount ? string.Format("p={0}",  //��������βҳ
                 pageCount) : "";     
           
            this.Items = new List<OptionItem>();
            for (int i = 1; i <= pageCount; i++)  //�����б�ѭ���ܵ�ҳ��
            {
               
                OptionItem item = new OptionItem();
                item.Text = i.ToString();                          
                item.SelectedString = i == currentPage ? "selected='selected'" : string.Empty;
                item.Value = string.Format("yjfl.aspx?p={0}", i);                
                this.Items.Add(item);
            }
      
        }

        private DataTable GetProductFormDB(int begin, int end, string name)
        {
               SqlParameter[] coll=
                     {
                     new SqlParameter("@begin",begin),
                     new SqlParameter("@end",end),
                     new SqlParameter("@���ϱ���",name)
                    
                
                    }
                    dt1=objConn.ExecuteProcForTable("yj_cl_Paging",coll)

            return dt1;
        }

        //�����ݿ��ȡ��¼��������
        private int GetProductCount()
        {           
           string name= Request["name"];
            string sql = "select count(cl_Id) from ���ϱ� where left(���ϱ���,2)='"+name+"'";           
                object obj = objConn.DBLook(sql);
                int count = (int)obj;
                return count;
            
        }
    </script>


    <div class="sc">
        <% string name=Request["name"];%>
        <div class="sc1">
            <a href="index.aspx" class="p1">��ҳ ></a>&nbsp&nbsp 
            <% foreach(System.Data.DataRow row in dt2.Rows){%>
            <a href="#"><%=row["��ʾ����"].ToString() %></a>
            <% } %>
        </div>

        <div class="sc2">
            <% foreach(System.Data.DataRow row in dt.Rows){%>
            <a href="ejfl.aspx?name=<%=row["�������"] %>"><%=row["��ʾ����"].ToString() %></a>

            <% } %>
        </div>

        <div class="sc3">
		    <%foreach(System.Data.DataRow row in this.dt_wz.Rows){
               String resume = row["ժҪ"].ToString();
               if (resume.Length > 40) {
                    resume = resume.Substring(0,40)+"...";
               }
            %>
            <div class="rh">
                <div class="rh1"><a href="wzxq.aspx?wz_id=<%=row["wz_id"]%>"><%=row["����"].ToString() %></a></div>
                <div class="rh2"><%=resume %></div>
            </div>
			<%}%>			
           
        </div>

        <div class="px0">
            <div class="px">����  <a href="#">����</a> <a href="#">����</a></div>
        </div>


        <div class="pxleft">
		    
            <% foreach(System.Data.DataRow row in dt1.Rows)
               {%>
            <div class="pxtu">
                <a href="clxx.aspx?cl_id=<%=row["cl_id"]%>">
				
				<%

                    String imgsrc= "images/222_03.jpg";
                   
                        
                         Object result =objConn.DBLook("select  top 1 ��ŵ�ַ from ���϶�ý����Ϣ�� where cl_id ='"
                        +row["cl_id"]+"' and ��С='С'");
                         if (result != null) {
                             imgsrc = result.ToString();
                         }
                  
                    Response.Write("<img src="+imgsrc+ " width=150px height=150px />");
                
				
				%>
				</a>
                <span class="pxtu1"><%=row["��ʾ��"].ToString()%></span>
               
            </div>
            <% } %>
        </div>


        <!-- ʯ�Ĺ��ҳ�� ����-->

        <!-- ���������ʯ�� ��ʼ-->
        <div class="pxright0">
            <div class="pxright">
                <div class="pxright1">
                    <ul>
                        <% foreach(System.Data.DataRow row in dt3.Rows){%>
                        <li><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>"><%=row["��ʾ��"].ToString()%></a></li>
                        <%}%>
                    </ul>

                </div>
            </div>
            <div class="pxright2">
                <a href="#">
                    <img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a>
            </div>
        </div>


    </div>
    <!-- ���������ʯ�� ����-->



    <!-- ��ҳ ʯ����ҳ ����-->
    <div>
        <div class="fy2">
            <div class="fy3">
                <% if(current_page!=1) { %>
                <a href="yjfl.aspx?<%=cpPrev %>&name=<%=name%>" class="p">��һҳ</a>
                <% } %>
                <a href="yjfl.aspx?p=1&name=<%=name%>" class="p">1</a>
                <% if(current_page>1) { %>
                <a href="yjfl.aspx?p=2&name=<%=name%>" class="p">2</a>
                <% } %>
                <% if(current_page>2) { %>
                <a href="yjfl.aspx?p=3&name=<%=name%>" class="p">3������</a>
                <% } %>
                <% if(current_page<pageCount_page) { %>
                <a href="yjfl.aspx?<%=cpNext %>&name=<%=name%>" class="p">��һҳ</a>
                <% } %>
                <% if(current_page!=pageCount_page) { %>
                <a href="yjfl.aspx?<%=cpLast %>&name=<%=name%>" class="p">βҳ</a>
                <% } %>


  
ֱ�ӵ���  
    <select onchange="window.location=this.value" name="" class="p">
        <% foreach (var v in this.Items)  { %>
        <option value="<%=v.Value %>&name=<%=name%>" <%=v.SelectedString %>><%=v.Text %></option>

        <%} %>
    </select>
                ҳ
            </div>
        </div>
    </div>
    <!-- ʯ�Ĺ��ҳ�� ��ʼ-->


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
