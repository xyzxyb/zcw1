<%@ Control Language="C#" AutoEventWireup="true" CodeFile="top10brand.ascx.cs" Inherits="asp_include_top10brand" %>
<div class="gz2">
    <div class="wz2">

        <ul>

            <% foreach(System.Data.DataRow row in dt.Rows){%>
            <li><a href="ppxx.aspx?pp_id=<%=row["pp_id"]%>"><%=row["品牌名称"].ToString() %></a></li>
            <% } %>
        </ul>
    </div>
</div>