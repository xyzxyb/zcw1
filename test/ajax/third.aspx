<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.UI" %>
<%@ Import Namespace="System.Text" %>

<%

	String id = Convert.ToString(Request["id"]);
	//Response.Write(id);
	
	if (id.Equals("0101")) //���� 
	{
		Response.Write("��������  <input type=input value = 010101>����");
	}
	else if (id.Equals("0201")) //����
	{
		Response.Write("����������  <input type=input value = 010101>����");
	}
	else if (id.Equals("0301")) //�Ϻ�
	{
		Response.Write("�Ϻ�����  <input type=input value = 010101>����");
	}
		
%>
