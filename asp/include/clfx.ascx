<%@ Control Language="C#" AutoEventWireup="true" CodeFile="clfx.ascx.cs" Inherits="asp_include_clfx" %>

<div class="clfx">
    <div class="clfx1">
        <div class="clfx2">
            <img src="images/biao_03.jpg" />
            材料发现
        </div>
        <span class="more"><a href="wzlb.aspx?id=材料发现 ">
            <img src="images/more_03.jpg" /></a></span>
    </div>
    <div class="clfx3">
        <ul>
            <% foreach(System.Data.DataRow row in dt.Rows){%>
            <li><a href="wzxq.aspx?wz_id=<%=(int)row["wz_id"]%>"><%=row["标题"].ToString() %></a></li>


            <% } %>
        </ul>
    </div>
</div>


<div class="clfx">
    <div class="clfx1">
        <div class="clfx2">
            <img src="images/biao_03.jpg" />
            材料导购
        </div>
        <span class="more"><a href="wzlb.aspx?id=材料导购 ">
            <img src="images/more_03.jpg" /></a></span>
    </div>
    <div class="clfx3">
        <ul>
            <% foreach(System.Data.DataRow row in dt1.Rows){%>
            <li><a href="wzxq.aspx?wz_id=<%=(int)row["wz_id"]%>"><%=row["标题"].ToString() %></a></li>


            <% } %>
        </ul>
    </div>
</div>


<div class="clfx">
    <div class="clfx1">
        <div class="clfx2">
            <img src="images/biao_03.jpg" />
            材料评测
        </div>
        <span class="more"><a href="wzlb.aspx?id=材料评测 ">
            <img src="images/more_03.jpg" /></a></span>
    </div>
    <div class="clfx3">
        <ul>
            <% foreach(System.Data.DataRow row in dt2.Rows){%>
            <li><a href="wzxq.aspx?wz_id=<%=(int)row["wz_id"]%>"><%=row["标题"].ToString() %></a></li>

            <% } %>
        </ul>
    </div>
</div>

<div class="clfx">
    <div class="clfx1">
        <div class="clfx2">
            <img src="images/biao_03.jpg" />
            材料百科
        </div>
        <span class="more"><a href="wzlb.aspx?id=材料百科 ">
            <img src="images/more_03.jpg" /></a></span>
    </div>
    <div class="clfx3">
        <ul>
            <% foreach(System.Data.DataRow row in dt3.Rows){%>
            <li><a href="wzxq.aspx?wz_id=<%=(int)row["wz_id"]%>"><%=row["标题"].ToString() %></a></li>

            <% } %>
        </ul>
    </div>
</div>

