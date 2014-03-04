<%@ Control Language="C#" AutoEventWireup="true" CodeFile="menu.ascx.cs" Inherits="asp_include_menu" %>
<div class="dh">
    <ul>
        <% foreach (var v in this.Items1){%>
        <li><a href="yjfl.aspx?name=<%=v.Sid.ToString() %>"><%=v.Name%></a>
            <ul style="left: -39px; width: 152px;">
                <%  foreach (var vr in this.Items2){				
                %>
                <%if (vr.Sid.ToString().Substring(0, 2) == v.Sid.ToString())
           {%>
                <li><a href="ejfl.aspx?name=<%=vr.Sid %>"><%=vr.Name%></a></li>
                <%} %>
                <% } %>
            </ul>
        </li>
        <% } %>


        <li><a href="#">更多</a>

            <ul style="left: -677px;">
                <li></li>
                <li></li>
                <% foreach (var v1 in this.Items3){%>
                <li><a class="hide" href="yjfl.aspx?name=<%=v1.Sid.ToString() %>" style="background: url(images/dh_04.jpg); color: #FFF"><%=v1.Name%></a>
                    <ul style="left: -11px;">
                        <%  foreach (var vr in this.Items2){				
                        %>
                        <%if (vr.Sid.ToString().Substring(0, 2) == v1.Sid.ToString())
           {%>
                        <li><a href="ejfl.aspx?name=<%=vr.Sid %>"><%=vr.Name%></a></li>
                        <%} %>
                        <% } %>
                    </ul>
                </li>
                <% } %>
            </ul>

        </li>
    </ul>
</div>
