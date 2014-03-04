using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class asp_include_pages : System.Web.UI.UserControl
{
    protected DataTable dt = new DataTable();
    DataConn objConn = new DataConn();
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataReader dr = objConn.sqlDataReader("select count(wz_id),标题,发表时间 from 文章表 where 文档类型='材料发现' group by wz_id,标题,发表时间  ");
        while (dr.Read())
        {
            int str = (int)dr.GetInt32(0);
            OutputBySize(str);
        }
        objConn.Close();
    }

    public string OutputBySize(int _intTotalPage)//分页函数
    {
        string _strRet = "";
        int _intCurrentPage = 1;//设置第一页为初始页                           
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
            _strPageInfo = "<a href=?ps=" + (_intCurrentPage - 1) + ">上一页</a>" + _strPageInfo;
        if (_intCurrentPage < _intTotalPage)
            _strPageInfo += "<a href=?ps=" + (_intCurrentPage + 1) + ">下一页</a>";

        _strRet += 5;    //输出显示各个页码        
        return _strRet;
    }
}