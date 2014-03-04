<%@ Page Language="C#" AutoEventWireup="true" CodeFile="header.aspx.cs" Inherits="asp_static_header" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <div class="box">
    <div class="top"></div>
    <div class="logo">
        <a href="index.aspx">
            <img src="images/logo_03.jpg" /></a>
    </div>

    <div class="sous">
        <form id="form1" name="form1" method="post" action="ss.aspx">
            <input name="sou" type="text" class="sou" />
            <img src="images/sss_03.jpg" onclick="javascript:fsubmit(document.form1);">
        </form>
    </div>
    <%		            
			if ((QQ_id == null ) || (QQ_id != null && logout!= null ))
			{
    %>
    <div class="anniu"><a onclick=clickMe("gysdl.aspx")>供应商登录</a></div>
    <div class="anniu"><a onclick=clickMe("cgsdl.aspx")>采购商登录</a></div>
    <%      }else {%>
    <div class="anniu">
        <a onclick=clickMe("gysdc.aspx")>供应商登出</a>
    </div>
    
    <div class="anniu">
         <a onclick=clickMe("gysdc.aspx")>采购商登出</a>
    </div>
   
    <%		}%>
        <script>
            function clickMe(url) {
                //var url = "cgsdl.aspx";
                window.open(url, "", "height=400,width=400,status=no,location=no,toolbar=no,directories=no,menubar=yes");
            }
            function fsubmit(obj) {
                obj.submit();
            }

    </script>

</body>
</html>
