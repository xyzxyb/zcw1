<!--
        ���϶��������б�ҳ��
        �ļ�����ejfl.ascx
        ���������name [�������]
               
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
    <script src="Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            $("#ckAll").click(function () {
                var v = $(this).attr("checked");//��ȡ"ȫѡ��ѡ��"                
                $(":checkbox.ck").attr("checked", v);//����class=ck�ĸ�ѡ���Ƿ�ѡ��
            });
            $(":checkbox.ck").click(function () {
                var a = $(":checkbox.ck").size(); //��ȡ���е�class=ck�ĸ�ѡ������                
                var b = $(":checkbox.ck:checked").size();//��ȡ���е�class=ck,���ұ�ѡ�е� ��ѡ������
                var c = a == b;
                $("#ckAll").attr("checked", c);
            });
        });
    </script>
    <title>����������ϸҳ��</title>
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
         
        protected DataTable dt = new DataTable();   //һ����������
        protected DataTable dt1 = new DataTable();  //������������ 
		protected DataTable dt2 = new DataTable();  //Ʒ��(�Ͷ���������ص�Ʒ��) ���Ϸ������fl_id Ʒ���ֵ��й�ϵû�ж�Ӧ
		protected DataTable dt3 = new DataTable();  //�������������µĲ���(���������ʯ��)
		protected DataTable dt4 = new DataTable();  //�������Ʒ�ҳ (��С���е����в��Ͻ��з�ҳ)
		protected DataTable dt_wz = new DataTable();  //�����ѡ����ʯ�������(���±�)
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
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
                       
            String name= Request["name"];
			string name1=name.ToString().Substring(0, 2); //ȡ�����λ�ַ���
            SqlDataAdapter da = new SqlDataAdapter("select ��ʾ����,������� from ���Ϸ���� where  left(�������,2)='"+name1+"' and len(�������)='2'  ", conn);            
            DataSet ds = new DataSet();
            da.Fill(ds, "���Ϸ����"); 
            dt = ds.Tables[0];
			
			SqlDataAdapter da1 = new SqlDataAdapter("select ��ʾ���� from ���Ϸ���� where �������='"+name+"' ", conn);            
            DataSet ds1 = new DataSet();
            da1.Fill(ds1, "���Ϸ����"); 
            dt1 = ds1.Tables[0];
			
			SqlDataAdapter da2 = new SqlDataAdapter("select distinct Ʒ������ from Ʒ���ֵ� where  fl_id in(select ������� from ���Ϸ���� where �������='"+name+"') ", conn);            
            DataSet ds2 = new DataSet();
            da2.Fill(ds2, "Ʒ���ֵ�"); 
            dt2 = ds2.Tables[0];
			
			SqlDataAdapter da3 = new SqlDataAdapter("select ��ʾ��,����ͺ�,�������,cl_id from ���ϱ� where �������='"+name+"' ", conn);            
            DataSet ds3 = new DataSet();
            da3.Fill(ds3, "���ϱ�"); 
            dt3 = ds3.Tables[0];
			
			SqlDataAdapter da_wz = new  SqlDataAdapter("select top 4 ����,ժҪ,wz_id from ���±� where left(�������,4)='"+name+"' ",conn);
			DataSet ds_wz = new DataSet();
			da_wz.Fill(ds_wz,"���±�");
			dt_wz = ds_wz.Tables[0];
			
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
			//string name1 = name.ToString().Substring(0, 4);    //���������ഫ�����Ĳ��ϱ���ȡǰ��λ��Ϊ����ִ�д洢����
            dt4 = this.GetProductFormDB(begin, end,name);
            this.SetNavLink(p, c,name);   
		} 
		
		protected string cpPrev = "";
        protected string cpNext = "";
        protected string cpLast = "";       
        private void SetNavLink(int currentPage, int pageCount,string name)
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
                item.Value = string.Format("ejfl.aspx?p={0}&name={1}", i,name);                
                this.Items.Add(item);
            }
      
        }

        private DataTable GetProductFormDB(int begin, int end, string name)
        {
            string connString = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;         
            SqlCommand cmd = new SqlCommand("ej_cl_Paging");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@begin", SqlDbType.Int).Value = begin;  //��ʼҳ��һ����¼
            cmd.Parameters.Add("@end", SqlDbType.Int).Value = end;      //��ʼҳ���һ����¼
			cmd.Parameters.Add("@���ϱ���", SqlDbType.VarChar,20).Value = name; //�����ϱ�������ϱ�,ִ�д洢����

            SqlDataAdapter sda = new SqlDataAdapter(cmd);          
            using (SqlConnection conn = new SqlConnection(connString))
            {
                cmd.Connection = conn;
                conn.Open();
                sda.Fill(dt4);
                conn.Close();
            }
            return dt4;
        }

        //�����ݿ��ȡ��¼��������
        private int GetProductCount()
        {
            string connString = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            String name= Request["name"];
            string sql = "select count(cl_Id) from ���ϱ� where left(���ϱ���,4)='"+name+"'";
            SqlCommand cmd = new SqlCommand(sql);
            using (SqlConnection conn = new SqlConnection(connString))
            {
                cmd.Connection = conn;
                conn.Open();
                object obj = cmd.ExecuteScalar();
                conn.Close();
                int count = (int)obj;
                return count;
            }
        }
    </script>


    <div class="sc">
        <div class="sc1">
            <a href="index.aspx">��ҳ ></a>&nbsp&nbsp&nbsp

 <% foreach(System.Data.DataRow row in dt.Rows){%>
            <a href="yjfl.aspx?name=<%=row["�������"]%>"><%=row["��ʾ����"].ToString() %></a>
            <% } %>
 > 
 <% foreach(System.Data.DataRow row in dt1.Rows){%>
            <a href="#"><%=row["��ʾ����"].ToString() %></a>
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

        <div class="xzss">
            <div class="ppxz">
                <div class="ppxz1">Ʒ�ƣ�</div>
                <div class="ppxz2">
                    <a href="#">
                    <img src="images/qwez.jpg" /></a>

                    <% foreach(System.Data.DataRow row in dt2.Rows){%>
                    <a href="#"><%=row["Ʒ������"].ToString() %></a>
                    <% } %>
                </div>
            </div>
            <div class="ppxz">
                <div class="ppxz1">����</div>
                <div class="ppxz2"><a href="#">
                    <img src="images/qwez.jpg" /></a> <a href="#">������</a> <a href="#">������</a> <a href="#">��̨��</a></div>
            </div>
            <div class="ppxz">

                <div class="ppxz1">���ϣ�</div>
                <div class="ppxz2">
                    <a href="#">
                        <img src="images/qwez.jpg" /></a>

                    <% foreach(System.Data.DataRow row in dt3.Rows){%>
                    <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>"><%=row["��ʾ��"].ToString() %></a>
                    <%}%>
                </div>
            </div>
            <div class="ppxz">
                <div class="ppxz1">���ࣺ</div>
                <div class="ppxz2"></a> <a href="#">����1</a> <a href="#">����2</a> <a href="#">����3</a></div>
            </div>

            <div class="dlspx">
                <span class="dlspx1">����</span>
                <span class="dlspx2"><a href="#">Ĭ��</a></span>
                <span class="dlspx3"><a href="#">����</a><img src="images/qweqw_03.jpg" /></span>
                <span class="dlspx3"><a href="#">����</a><img src="images/qweqw_03.jpg" /></span>
                <span class="dlspx3">
                    <input name="" type="checkbox" value="" id="ckAll" class="fx" /><a href="#">ȫѡ</a></span>
                <span class="dlspx4"><a href="#">���ղأ����ڲ���</a></span>
            </div>
        </div>

        <div class="dlspxl">

            <% foreach(System.Data.DataRow row in dt4.Rows){%>

            <div class="dlspxt">
                <a href="clxx.aspx?cl_id=<%=row["cl_id"] %>">

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
                    
                    <div class="dlspxt1">
                        <span class="dlsl"><%=row["��ʾ��"].ToString() %></span>
                        <span class="dlspx3">
                            <input name="" type="checkbox" value="" class="ck" />
                            �ղ�</span>
                        <span class="dlsgg">���<%=row["����ͺ�"].ToString() %></span>
                    </div>
            </div>
            <% } %>
        </div>



        <div class="pxright0">
            <div class="pxright">
                <div class="pxright1">
                    <ul>

                        <% foreach(System.Data.DataRow row in dt3.Rows){%>
                        <li><a href="clxx.aspx?cl_id=<%=row["cl_id"]%>"><%=row["��ʾ��"].ToString() %></a></li>
                        <%}%>
                    </ul>

                </div>
            </div>
            <div class="pxright2"><a href="#">
                <img src="images/ggg2_03.jpg" /></a><a href="#"><img src="images/ggg2_03.jpg" /></a></div>
        </div>

    </div>


    <div class="fy2">
        <div class="fy3">
		    <%string name = Request["name"];%>
            <% if(current_page!=1) { %>
            <a href="ejfl.aspx?<%=cpPrev %>&name=<%=name%>" class="p">��һҳ</a>
            <% } %>
            <a href="ejfl.aspx?p=1&name=<%=name%>" class="p">1</a>
            <% if(current_page>1) { %>
            <a href="ejfl.aspx?p=2&name=<%=name%>" class="p">2</a>
            <% } %>
            <% if(current_page>2) { %>
            <a href="ejfl.aspx?p=3&name=<%=name%>" class="p">3������</a>
            <% } %>
            <% if(current_page<pageCount_page) { %>
            <a href="ejfl.aspx?<%=cpNext %>&name=<%=name%>" class="p">��һҳ</a>
            <% } %>
            <% if(current_page!=pageCount_page) { %>
            <a href="ejfl.aspx?<%=cpLast %>&name=<%=name%>" class="p">βҳ</a>
            <% } %>

 ֱ�ӵ���  
    <select onchange="window.location=this.value" name="" class="p">
        <% foreach (var v in this.Items)
   { %>
        <option value="<%=v.Value %>" <%=v.SelectedString %>><%=v.Text %></option>

        <%} %>
    </select>
            ҳ
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



</body>
</html>
