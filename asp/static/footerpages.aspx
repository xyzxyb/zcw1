<%-- ���Ϸ�������ҳ��--%>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Web" %>


<script runat="server">
        protected DataTable dt = new DataTable();
		DataConn objConn=new DataConn();
        public string SQL="";
        protected void Page_Load(object sender, EventArgs e)
        {
            SQL="select count(wz_id),����,����ʱ�� from ���±� where �ĵ�����='���Ϸ���' group by wz_id,����,����ʱ��  ";
           // string constr = ConfigurationManager.ConnectionStrings["DNS"].ConnectionString;
          //  SqlConnection conn = new SqlConnection(constr);
          //  conn.Open();         
        //string strr = "select count(wz_id),����,����ʱ�� from ���±� where �ĵ�����='���Ϸ���' group by wz_id,����,����ʱ��  ";
        //    SqlCommand cmd = new SqlCommand(strr, conn);
          //  SqlDataReader dr = cmd.ExecuteReader();
              SqlDataReader dr = null;
             dr=objConn.sqlDataReader(SQL);
            while (dr.Read())
            {                
                int str = (int)dr.GetInt32(0);
                OutputBySize(str);
            }
           objConn.Close(); 
        }

               public string OutputBySize(int _intTotalPage)//��ҳ����
        {
                string _strRet = "";           
                int _intCurrentPage = 1;//���õ�һҳΪ��ʼҳ                           
                if (Request.QueryString["ps"] != null)
                {//set Current page number
                  
                        _intCurrentPage = Convert.ToInt32(Request.QueryString["ps"]);
                        if (_intCurrentPage > _intTotalPage)
                        {
                            _intCurrentPage = _intTotalPage;
                        }
                    }          
               
                string _strPageInfo = "";
                for (int i = 1; i <= _intTotalPage; i++)
                {
                    if (i == _intCurrentPage)
                        _strPageInfo += "[" + i + "]";
                    else
                        _strPageInfo += " <a href=?ps=" + i + ">[" + i + "]</a> ";
                }
                if (_intCurrentPage > 1)
                    _strPageInfo = "<a href=?ps=" + (_intCurrentPage - 1) + ">��һҳ</a>" + _strPageInfo;
                if (_intCurrentPage < _intTotalPage)
                    _strPageInfo += "<a href=?ps=" + (_intCurrentPage + 1) + ">��һҳ</a>";                    
         
                _strRet += 5;    //�����ʾ����ҳ��        
                return _strRet;
        }
</script>

<div class="fy0">
<div class="fy">

 <a href="#"> βҳ</a>  
ֱ�ӵ��� <select name="" class="fu"><option>1</option></select>      
ҳ</div></div>

</div>