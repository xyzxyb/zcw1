<%@ Control Language="C#" AutoEventWireup="true" CodeFile="rxcp.ascx.cs" Inherits="asp_include_rxcp" %>
<div class="rxcp">
    <div class="rxcp1">
        <div class="rxcp2">
            <img src="images/biao_03.jpg" />热销产品</div>
        <span class="more"><a href="#">
            <img src="images/more_03.jpg" /></a></span></div>
    <div class="rxcp3">
        <div id="demo" style="overflow: hidden; width: 960px;">
            <table cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td id="demo1" valign="top" align="center">
                        <table cellpadding="2" cellspacing="0" border="0" class="tu1">
						
                            <tr align="center">
                                <%foreach(System.Data.DataRow row in this.dt_cltp.Rows){%>
                                <td>
                                    <div class="pii"><a href="clxx.aspx?cl_id=<%=row["cl_id"].ToString()%>">
                                        <img src="<%=row["存放地址"].ToString() %>" width="167" height="159" /><%=row["材料名称"].ToString() %></a></div>
                                </td>
                                <%}%>

                            </tr>
							
                        </table>
                    </td>
                    <td id="demo2" valign="top"></td>
                </tr>
            </table>
        </div>
    </div>
</div>

