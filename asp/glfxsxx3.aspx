<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">


            public List<Option_gys> Items { get; set; }

            public class Option_gys
            {//����
                public string gys_name { get; set; }       //��Ӧ��
                public string gys_address { get; set; }    //��ַ
                public string gys_tel { get; set; }        //�绰
				public string gys_homepage { get; set; }   //��ҳ
				public string gys_fax { get; set; }        //����
                public string gys_area { get; set; }       //��������
                public string gys_user { get; set; }       //��ϵ��
				public string gys_user_phone { get; set; }       //��ϵ���ֻ� 
                public string gys_id { get; set; }       //��Ӧ��id				
            }
		   protected DataTable dt_gysxx = new DataTable();	
		   protected void Page_Load(object sender, EventArgs e)
           {
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);

            string fxs_id = Request["id"];   //��ȡ�����򴫹����ķ�����id

            String str_gysxx = "select ��Ӧ��,��ַ,�绰,��ҳ,����,��������,��ϵ��,��ϵ���ֻ�,gys_id from ���Ϲ�Ӧ����Ϣ�� where  gys_id='"+fxs_id+"' ";
            SqlDataAdapter da_gysxx = new SqlDataAdapter(str_gysxx, conn);
			DataSet ds_gysxx = new DataSet();
            da_gysxx.Fill(ds_gysxx, "���Ϲ�Ӧ����Ϣ��");
            dt_gysxx = ds_gysxx.Tables[0]; 
			
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
			this.Items = new List<Option_gys>();  //���ݱ�DataTableת����  
			   for(int x=0;x<dt_gysxx.Rows.Count;x++)
               {
                  DataRow dr2 = dt_gysxx.Rows[x];              
                  
		          Option_gys item = new Option_gys();
				  
				  item.gys_name = Convert.ToString(dr2["��Ӧ��"]);   
                  item.gys_address = Convert.ToString(dr2["��ַ"]);
                  item.gys_tel = Convert.ToString(dr2["�绰"]);
				  item.gys_homepage = Convert.ToString(dr2["��ҳ"]);   
                  item.gys_fax = Convert.ToString(dr2["����"]);
                  item.gys_area = Convert.ToString(dr2["��������"]);
				  item.gys_user = Convert.ToString(dr2["��ϵ��"]);   
                  item.gys_user_phone = Convert.ToString(dr2["��ϵ���ֻ�"]);
				  item.gys_id = Convert.ToString(dr2["gys_id"]);
                 
                  this.Items.Add(item);                
			   }
			
			   string jsonStr = serializer.Serialize(Items); 
			   Response.Clear(); 
			   Response.Write(jsonStr);   //��ǰ��glscsxx.aspx���json�ַ���
			   Response.End();
			  }

</script>

