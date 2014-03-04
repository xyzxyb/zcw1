using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class asp_static_header : System.Web.UI.Page
{
    public HttpCookie QQ_id = null;
    public Object logout = null;
    protected void Page_Load(object sender, EventArgs e)
    {
         QQ_id = Request.Cookies["QQ_id"];
         logout = Session["logout"];
    }
}