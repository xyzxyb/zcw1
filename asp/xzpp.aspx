<!--
          ����Ʒ��  (�����������µ�Ʒ��)
		  �ļ���: xzpp.aspx              
		  �������gys_id
		  
         
-->


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript">

        function updateFL(id) {

            var xmlhttp;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    //document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
                    document.getElementById("ejflname").innerHTML = xmlhttp.responseText;
                }
            }
            xmlhttp.open("GET", "xzpp2.aspx?id=" + id, true);
            xmlhttp.send();
        }


    </script>
</head>
<body>


    <script runat="server">

        protected DataTable dt_yjfl = new DataTable();   //���Ϸ������
		protected String gys_id;

        protected void Page_Load(object sender, EventArgs e)
        {
            gys_id = Request["gys_id"].ToString();

            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);
            SqlDataAdapter da_yjfl = new SqlDataAdapter("select ��ʾ����,������� from ���Ϸ���� where len(�������)='2'", conn);
            DataSet ds_yjfl = new DataSet();
            da_yjfl.Fill(ds_yjfl, "���Ϸ����");            
            dt_yjfl = ds_yjfl.Tables[0];   
         }

    </script>


    <center>

        <form action="xzpp3.aspx" method="post">
            <div id="myDiv"></div>
            <table border="0" width="600px">

                <tr>
                    <td style="width: 120px; color: Blue">һ���������ƣ�
                    </td>
                    <td align="left">
                        <select id="yjflname" name="yjflname" style="width: 200px" onchange="updateFL(this.options[this.options.selectedIndex].value)">

                            <% foreach(System.Data.DataRow row in dt_yjfl.Rows){%>

                            <option value="<%=row["�������"] %>"><%=row["��ʾ����"]%></option>
                            <%}%>
                        </select>
                    </td>
                </tr>


                <tr>
                    <td style="width: 120px; color: Blue">�����������ƣ�
                    </td>
                    <td align="left">
                        <select id="ejflname" name="ejflname" style="width: 250px">


                            <option value="">��ѡ��С��</option>

                        </select>
                    </td>
                </tr>

                <tr>
                    <td style="color: Blue">Ʒ�����ƣ�
                    </td>
                    <td align="left">
                        <input type="text" id="" name="brandname" value="" />
                    </td>
                </tr>

                <tr>
                    <td style="color: Blue">�ȼ���
                    </td>
                    <td align="left">
                        <select name="grade" id="grade" >
                            <option value="һ��">һ��</option>
                            <option value="����">����</option>
                            <option value="����">����</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td valign="top" style="color: Blue">��Χ��
                    </td>
                    <td align="left">
                       
                        <select name="scope" id="scope" >
                            <option value="ȫ��">ȫ��</option>
                            <option value="����">����</option>                        
                        </select>
                    </td>
                </tr>

                <tr>
                    <td>
                        <input type="hidden" id="gys_id" name="gys_id" value=<%=gys_id %> />
                        <input type="submit" id="send" value="����" style="width: 100px" />
                    </td>
                    <td align="left">
                        <input type="button" id="close" value="�ر�" style="width: 100px" />
                    </td>
                </tr>
            </table>
        </form>
    </center>
</body>
</html>







