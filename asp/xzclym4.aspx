
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
            DataConn objConn=new DataConn();
            //String gys_id = Request["gys_id"]; 
			
            string yh_id = Convert.ToString(Session["yh_id"]);   //��ȡ�û�id	
			
            string str_gysxx_type = "select  gys_id from ���Ϲ�Ӧ����Ϣ�� where  yh_id='"+yh_id+"' ";            
            DataTable dt_gysxxs = objConn.GetDataTable(str_gysxx_type);
            string gys_id = Convert.ToString(dt_gysxxs.Rows[0]["gys_id"]);	  //141 �����û�id ��ȡ��Ӧ��id
				

            //��������д�����ݿ�
            {
              
                string cl_name = Request["cl_name"];                //��������
                string cl_type = Request["cl_type"];                //����ͺ�              
                string cl_bit = Request["cl_bit"];                  //������λ
                string cl_volumetric = Request["cl_volumetric"];        //��λ���
				string cl_height = Request["cl_height"];                //��λ����
                string cl_instruction = Request["cl_instruction"];      //˵��       
                string brand = Request["brand"];                        //Ʒ��id(��ȡ���������б���value��ֵ)
                
				
                string str_xzcl = "insert into  ���ϱ�(��ʾ��,����ͺ�,������λ,��λ���,��λ����,˵��,�Ƿ�����,pp_id) "
				+"values('" + cl_name + "','"+cl_type+"','" + cl_bit + "','" + cl_volumetric + "', "
				+" '" + cl_height + "','"+cl_instruction+"','1','"+brand+"' ) ";          
                //���²��ϱ�
    objConn.ExecuteSQL(str_xzcl,false);
			    
				//��ȫ���ϱ���Ϣ
				string yjflname = Request["yjflname"];              //�󼶷������� (��ȡ���������б���value��ֵ ������� ��λ)              
                string ejflname = Request["ejflname"];              //������������  (������� 4λ)
                     
                string flname = ejflname;
                if (flname.Equals("0"))  
				flname = yjflname;
				 DataTable Sdt_cl = new DataTable();
				Sdt_cl = objConn.GetDataTable ("select ��������,���Ա���,��� from ���Ϸ�������ֵ�� where �������='"+flname+"' ");
				
				string cl_clbm = Convert.ToString(dt_cl.Rows[0]["���Ա���"]);  //���ϱ���
				string cl_clbh = Convert.ToString(dt_cl.Rows[0]["���"]);      //���ϱ��
				string cl_clflname = Convert.ToString(dt_cl.Rows[0]["��������"]);      //��������
				
                string cl_update = "update ���ϱ� set gys_id='"+gys_id+"', "
				+"cl_id= (select myID from ���ϱ� where ��ʾ��='"+cl_name+"'),"
				+"fl_id = (select fl_id from ���Ϸ���� where �������='"+flname+"'),"
				+"�������� = (select ��Ӧ�� from ���Ϲ�Ӧ����Ϣ�� where gys_id = '"+gys_id+"'),"
				+"���ϱ��� ='"+flname+"'+' "+cl_clbm+"'+'"+cl_clbh+"' , ������� = '"+flname+"', ��������='"+cl_clflname+"', "
				+"Ʒ������=(select Ʒ������ from Ʒ���ֵ� where pp_id='"+brand+"' ) where ��ʾ��='"+cl_name+"' ";
            
                int ret =objConn.ExecuteSQLForCount(cl_update,false);	
				
				//��ȡ������Ҫ���²������Ա�ı���
				string sx_names = Request["sx_names"];    //��ȡ������������ (���������б���value��ֵΪ��������flsx_id)
				string sx_codes = Request["sx_codes"];    //��ȡ�������Ա���
				string sx_id = Request["sx_id"];          //��ȡ��������id
				string cl_value = Request["cl_value"];    //��ȡ��������ֵ
				string cl_number = Request["cl_number"];    //��ȡ��������ֵ���
				string cl_ids = Request["cl_ids"];          //��ȡ����ֵid
				
                  DataTable dt_flsx = new DataTable();
				dt_flsx = objConn.GetDataTable("select ������������ from �������Ա� where flsx_id='"+sx_names+"' ");
				
				
				string cl_flsxmc = Convert.ToString(dt_flsx.Rows[0]["������������"]);  //������������
				
				string str_clsx = "insert into  �������Ա�(������������,�������Ա���,flsx_id,��������ֵ,��������ֵ���,flsxz_id) "
				+"values('" + cl_flsxmc + "','"+sx_codes+"','" + sx_id + "','" + cl_value + "', "
				+" '" + cl_number + "','"+cl_ids+"' ) "; 
				//���²������Ա�
				 objConn.ExecuteSQL(str_clsx,false);
				
				//��ȫ�������Ա�			
		        string str_clsx_update = "update �������Ա� set clsx_id=(select max(myid) from �������Ա� ), "
				+"cl_id=(select cl_id from ���ϱ� where ��ʾ��='"+cl_name+"'),"
				+"fl_id = (select fl_id from ���Ϸ���� where �������='"+flname+"'),"
				+"��������='"+cl_clflname+"',�������='"+flname+"',���ϱ���='"+flname+"'+' "+cl_clbm+"'+'"+cl_clbh+"', "
				+"��������='"+cl_name+"',��������ֵ����='"+sx_codes+"'+'"+cl_number+"' where ������������='"+cl_flsxmc+"' "
				+"and flsx_id='"+sx_id+"'and flsxz_id='"+cl_ids+"' ";
				objConn.ExecuteSQL(str_clsx_update,false);
            }	                    
		
     %>

    <body>
        <p>
        </p>             
        <a href="gysglcl.aspx" style="color: Blue" onclick="clickMe() ">�������ϳɹ�!�뷵��; </a>
        <script>
            //function clickMe() 
			{
                //window.close();
                //opener.location.reload();
            }
        </script>      

    </body>