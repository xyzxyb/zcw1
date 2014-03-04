<%@ Control Language="C#" AutoEventWireup="true" CodeFile="header2.ascx.cs" Inherits="asp_include_header2" %>



<div class="box">

    <div class="topx">
        <a href="gyszym.aspx">
            <img src="images/topx_02.jpg" /></a>
    </div>
    <div class="gyzy0">
        <div class="gyzy">
            尊敬的
			<%foreach(System.Data.DataRow row in this.dt_yh.Rows){%>            
            <span><%=row["姓名"].ToString() %></span>           
            <%}%>
            先生/女士，您好
        </div>
    </div>

