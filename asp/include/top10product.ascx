<%@ Control Language="C#" AutoEventWireup="true" CodeFile="top10product.ascx.cs" Inherits="asp_include_top10product" %>
<div class="gz">
    <div class="wz">
        <ul>

            <% foreach(System.Data.DataRow row in dt.Rows){%>

            <li><a href="clxx.aspx?cl_id=<%=row["cl_id"]%> "><%=row["显示名"].ToString() %></a></li>

            <% } %>
        </ul>
    </div>
</div>

