<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Text" %>

<%

	String id = Convert.ToString(Request["id"]);
	//Response.Write(id);
	Response.Write("<option value = 0101>��ѡ������</option>");
	if (id.Equals("01")) //���� 
	{
		Response.Write("<option value = 0101>����</option><option value = 0102>���</option><option value = 0103>�ӱ�</option>");
	}
	else if (id.Equals("02")){
		Response.Write("<option value = 0201>������</option><option value = 0202>����</option><option value = 0203>����</option>");
	}
	else if (id.Equals("03")){
		Response.Write("<option value = 0301>�Ϻ�</option><option value = 0302>����</option><option value = 0303>�㽭</option>");
	}
		
%>
