<!--
          ��������Ʒ��  (���������ӷ����µ�Ʒ��)
		  �ļ���: xzfxpp.aspx              
		  �������gys_id	  
         
-->


<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<script runat="server">

        protected DataTable dt_ppxx = new DataTable();   //Ʒ���ֵ�
		protected String gys_id;
        protected String yh_id;
    DataConn objConn=new DataConn();
        protected void Page_Load(object sender, EventArgs e)
        {
            gys_id = Request["gys_id"].ToString();
            yh_id = Session["yh_id"].ToString();
            dt_ppxx = objConn.GetDataTable("select pp_id,Ʒ������,�ȼ�,��Χ,��������,�������,fl_id,������,scs_id from Ʒ���ֵ� ");
            
         }

</script>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript">

        function updateFL(id) {

            var scs_array = new Array();
            var scs_id_array = new Array();
            var grade_array = new Array();
            var scope_array = new Array();
            var fl_id_array = new Array();
            var fl_name_array = new Array();
            var fl_code_array = new Array();
            var pp_id_array = new Array();
            var pp_name_array = new Array();

            <%
                for (int i=0;i<dt_ppxx.Rows.Count;i++)
                {
                    Response.Write("            scs_array["+i+"] = '"+dt_ppxx.Rows[i]["������"]+"';\n");
                    Response.Write("            scs_id_array["+i+"] = '"+dt_ppxx.Rows[i]["scs_id"]+"';\n");
                    Response.Write("            grade_array["+i+"] = '"+dt_ppxx.Rows[i]["�ȼ�"]+"';\n");
                    Response.Write("            scope_array["+i+"] = '"+dt_ppxx.Rows[i]["��Χ"]+"';\n");
                    Response.Write("            fl_id_array["+i+"] = '"+dt_ppxx.Rows[i]["fl_id"]+"';\n");
                    Response.Write("            pp_id_array["+i+"] = '"+dt_ppxx.Rows[i]["pp_id"]+"';\n");
                    Response.Write("            fl_name_array["+i+"] = '"+dt_ppxx.Rows[i]["��������"]+"';\n");
                    Response.Write("            fl_code_array["+i+"] = '"+dt_ppxx.Rows[i]["�������"]+"';\n");
                    Response.Write("            pp_name_array["+i+"] = '"+dt_ppxx.Rows[i]["Ʒ������"]+"';\n");
                }
              
            %> 
            document.getElementById("scs").innerHTML = scs_array[id];
            document.getElementById("fl_name").innerHTML = fl_name_array[id];
            document.getElementById("grade").innerHTML = grade_array[id];
            document.getElementById("scope").innerHTML = scope_array[id];

            document.getElementById("pp_id").value = pp_id_array[id];
            document.getElementById("pp_name").value = pp_name_array[id];
        }


    </script>
</head>
<body>


    


    <center>

        <form action="xzfxpp2.aspx" method="post">
            <div id="myDiv"></div>
            <table border="0" width="600px">

                <tr>
                    <td style="width: 120px; color: Blue">Ʒ�����ƣ�
                    </td>
                    <td align="left">
                        <select id="yjflname" name="yjflname" style="width: 200px" onchange="updateFL(this.options[this.options.selectedIndex].value)">

                            <% for (int i=0;i< dt_ppxx.Rows.Count;i++) {
                                Response.Write("<option value='"+i+"'>"+dt_ppxx.Rows[i]["Ʒ������"]+"</option>");
                            }%>
                        </select>
                    </td>
                </tr>


                <tr>
                    <td style="width: 120px; color: Blue">�����̣�
                    </td>
                    <td align="left">
                        <div id="scs"><%=dt_ppxx.Rows[0]["������"] %> </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 120px; color: Blue">�ȼ���
                    </td>
                    <td align="left">
                        <div id="grade"><%=dt_ppxx.Rows[0]["�ȼ�"] %> </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 120px; color: Blue">��Χ��
                    </td>
                    <td align="left">
                        <div id="scope"><%=dt_ppxx.Rows[0]["��Χ"] %>  </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 120px; color: Blue">���ࣺ
                    </td>
                    <td align="left">
                        <div id="fl_name"> <%=dt_ppxx.Rows[0]["��������"] %> </div>
                    </td>
                </tr>

                

                <tr>
                    <td>
                        <input type="hidden" id="fxs_id" name="fxs_id" value=<%=gys_id %> />
                        <input type="hidden" id="pp_id" name="pp_id" value="<%=dt_ppxx.Rows[0]["pp_id"] %> " />
                        <input type="hidden" id="pp_name" name="pp_name" value="<%=dt_ppxx.Rows[0]["Ʒ������"] %> " />
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







