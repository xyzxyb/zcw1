<%@ Control Language="C#" AutoEventWireup="true" CodeFile="top10manu.ascx.cs" Inherits="asp_include_top10manu" %>
<div class="gz1">
    <div class="wz1">
        <ul>
            <% foreach(var v  in  Items){%>

            
            <li><a href="gysxx.aspx?gys_id=<%=v.Gys_id%>"><%=v.Manufacturers %></a></li>

            <%} %>
           

        </ul>
    </div>
</div>
