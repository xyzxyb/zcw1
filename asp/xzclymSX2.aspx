<!--   
      �ļ���:xzclymSX2.aspx
      �������: id (��������id)
-->
	  
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">
    
           	public class Option_SXZ
            {//����
                public string SXZ_name { get; set; }  //����ֵ
                public string SXZ_id { get; set; }    //����ֵid
                public string SXZ_code { get; set; }  //���
            }
			public List<Option_SXZ> Items { get; set; }
		    protected void Page_Load(object sender, EventArgs e)
            {
               String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
               SqlConnection conn = new SqlConnection(constr);

               string flsx_id = Request["id"];   //��ȡ�������ƴ������ķ���id 
               //�ȸ��ݴ�������flsx_id ����������			
               SqlDataAdapter da_flsxid = new SqlDataAdapter("select ������� from ���Ϸ�������ֵ�� where flsx_id='"+flsx_id+"'",conn);    //���� ����
			   DataSet ds_flsxid = new DataSet();
			   da_flsxid.Fill(ds_flsxid,"���Ϸ�������ֵ��");
			   DataTable dt_flsxid = ds_flsxid.Tables[0];	
               string clflsx_id = Convert.ToString(dt_flsxid.Rows[0]["�������"]);	  //��ȡ�������		
			
			   //�Է������   �ͷ������ƴ������ķ���id ��ѯ����ֵ 
			   SqlDataAdapter da_flsx_id = new SqlDataAdapter("select ���,����ֵ,flsxz_id from ���Ϸ�������ֵ�� where �Ƿ�����=1 and �������='"+clflsx_id+"' and flsx_id='"+flsx_id+"' order by ���Ա���,���",conn);    //���� ����
			   DataSet ds_flsx_id = new DataSet();
			   da_flsx_id.Fill(ds_flsx_id,"���Ϸ�������ֵ��");
			   DataTable dt_flsx_id = ds_flsx_id.Tables[0];
			
			   System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
			   this.Items = new List<Option_SXZ>();  //���ݱ�DataTableת����  
			   for(int x=0;x<dt_flsx_id.Rows.Count;x++)
               {
                  DataRow dr2 = dt_flsx_id.Rows[x];              
                  
		          Option_SXZ item = new Option_SXZ();
				  item.SXZ_name = Convert.ToString(dr2["����ֵ"]);   //������ֵ���뼯��
                  item.SXZ_code = Convert.ToString(dr2["���"]);
                  item.SXZ_id = Convert.ToString(dr2["flsxz_id"]);
                  this.Items.Add(item);                
			   }
			
			   string jsonStr = serializer.Serialize(Items); 
			   Response.Clear(); 
			   Response.Write(jsonStr);   //��ǰ��xzclym.aspx���json�ַ���
			   Response.End();
			
			
			   //Response.Write("<option value='0'>��ѡ������ֵ</option>");
               //foreach(System.Data.DataRow row in dt_flsx_id.Rows) 
               //{
                    //Response.Write("<option value='"+row["flsxz_id"]+"'>"+row["����ֵ"]+"</option>");
               //}
	
            }

</script>










	
			