<!--   
      �ļ���:xzclymSX.aspx
      �������: id (�����������)
-->
	  
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">
    
           	public class Option_SX
            {
                public string SX_name { get; set; }
                public string SX_id { get; set; }
                public string SX_code { get; set; }
            }
       	    public List<Option_SX> Items { get; set; }
           protected void Page_Load(object sender, EventArgs e)
           {  
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);

            string ejfl_id = Request["id"];   //��ȡС�ഩ�����ķ������        
			
			
			SqlDataAdapter da_flsx = new SqlDataAdapter("select distinct ���Ա���,��������,flsx_id "
			+"from ���Ϸ�������ֵ�� where �Ƿ�����=1 and �������='"+ejfl_id+"' and flsx_id in(select flsx_id "
			+"from ���Ϸ������Ա� where �Ƿ�����=1 and �������='"+ejfl_id+"') order by ���Ա���",conn);    //���� ����
			DataSet ds_flsx = new DataSet();
			da_flsx.Fill(ds_flsx,"���Ϸ�������ֵ��");
			DataTable dt_flsx = ds_flsx.Tables[0];
			
		
			System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
			this.Items = new List<Option_SX>();  //���ݱ�DataTableת����  
			for(int x=0;x<dt_flsx.Rows.Count;x++)
            {
                 DataRow dr2 = dt_flsx.Rows[x];              
                  
		         Option_SX item = new Option_SX();
				 item.SX_name = Convert.ToString(dr2["��������"]);   //���������ƴ��뼯��
                 item.SX_code = Convert.ToString(dr2["���Ա���"]);
                 item.SX_id = Convert.ToString(dr2["flsx_id"]);
                 this.Items.Add(item);                
			}
			
			string jsonStr = serializer.Serialize(Items); 
			Response.Clear(); 
			Response.Write(jsonStr);   //��ǰ��xzclym.aspx���json�ַ���
			Response.End();
			
		
			
		
			//Response.Write("<option value='0'>��ѡ����������</option>");
            //foreach(System.Data.DataRow row in dt_flsx.Rows) 
            //{
                //Response.Write("<option value='"+row["flsx_id"]+"'>"+row["��������"]+"</option>");
			    
            //}
			
    }
</script>