
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Web" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
            String constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
            SqlConnection conn = new SqlConnection(constr);          
            //String gys_id = Request["gys_id"]; 
			
            String yh_id = Convert.ToString(Session["yh_id"]);   //��ȡ�û�id	
			
            String str_gysxx_type = "select  gys_id from ���Ϲ�Ӧ����Ϣ�� where  yh_id='"+yh_id+"' ";
            SqlDataAdapter da_gysxx_type = new SqlDataAdapter(str_gysxx_type, conn);
			DataSet ds_gysxx_type = new DataSet();
            da_gysxx_type.Fill(ds_gysxx_type, "���Ϲ�Ӧ����Ϣ��");
            DataTable dt_gysxxs = ds_gysxx_type.Tables[0];
            string gys_id = Convert.ToString(dt_gysxxs.Rows[0]["gys_id"]);	  //141 �����û�id ��ȡ��Ӧ��id
				

            //��������д�����ݿ�
            {
                conn.Open(); 
                				
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
				SqlCommand cmd_insert= new SqlCommand(str_xzcl, conn);
                cmd_insert.ExecuteNonQuery();	
			    
				//��ȫ���ϱ���Ϣ
				string yjflname = Request["yjflname"];              //�󼶷������� (��ȡ���������б���value��ֵ ������� ��λ)              
                string ejflname = Request["ejflname"];              //������������  (������� 4λ)
                     
                string flname = ejflname;
                if (flname.Equals("0"))  
				flname = yjflname;
				
				SqlDataAdapter ad_cl = new SqlDataAdapter ("select ��������,���Ա���,��� from ���Ϸ�������ֵ�� where �������='"+flname+"' ",conn);
				DataSet ds_cl = new  DataSet();
				DataTable dt_cl = new DataTable();
				ad_cl.Fill(ds_cl,"���Ϸ�������ֵ��");
				dt_cl = ds_cl.Tables[0];
				string cl_clbm = Convert.ToString(dt_cl.Rows[0]["���Ա���"]);  //���ϱ���
				string cl_clbh = Convert.ToString(dt_cl.Rows[0]["���"]);      //���ϱ��
				string cl_clflname = Convert.ToString(dt_cl.Rows[0]["��������"]);      //��������
				
                string cl_update = "update ���ϱ� set gys_id='"+gys_id+"', "
				+"cl_id= (select myID from ���ϱ� where ��ʾ��='"+cl_name+"'),"
				+"fl_id = (select fl_id from ���Ϸ���� where �������='"+flname+"'),"
				+"�������� = (select ��Ӧ�� from ���Ϲ�Ӧ����Ϣ�� where gys_id = '"+gys_id+"'),"
				+"���ϱ��� ='"+flname+"'+' "+cl_clbm+"'+'"+cl_clbh+"' , ������� = '"+flname+"', ��������='"+cl_clflname+"', "
				+"Ʒ������=(select Ʒ������ from Ʒ���ֵ� where pp_id='"+brand+"' ) where ��ʾ��='"+cl_name+"' ";
                SqlCommand cmd_update= new SqlCommand(cl_update, conn);
                int ret = (int)cmd_update.ExecuteNonQuery();	
				
				//��ȡ������Ҫ���²������Ա�ı���
				string sx_names = Request["sx_names"];    //��ȡ������������ (���������б���value��ֵΪ��������flsx_id)
				string sx_codes = Request["sx_codes"];    //��ȡ�������Ա���
				string sx_id = Request["sx_id"];          //��ȡ��������id
				string cl_value = Request["cl_value"];    //��ȡ��������ֵ
				string cl_number = Request["cl_number"];    //��ȡ��������ֵ���
				string cl_ids = Request["cl_ids"];          //��ȡ����ֵid
				
				SqlDataAdapter ad_flsx = new SqlDataAdapter ("select ������������ from �������Ա� where flsx_id='"+sx_names+"' ",conn);
				DataSet ds_flsx = new  DataSet();
				DataTable dt_flsx = new DataTable();
				ad_flsx.Fill(ds_flsx,"�������Ա�");
				dt_flsx = ds_flsx.Tables[0];
				string cl_flsxmc = Convert.ToString(dt_flsx.Rows[0]["������������"]);  //������������
				
				string str_clsx = "insert into  �������Ա�(������������,�������Ա���,flsx_id,��������ֵ,��������ֵ���,flsxz_id) "
				+"values('" + cl_flsxmc + "','"+sx_codes+"','" + sx_id + "','" + cl_value + "', "
				+" '" + cl_number + "','"+cl_ids+"' ) "; 
				//���²������Ա�
				SqlCommand cmd_clsx_insert= new SqlCommand(str_clsx, conn);    //ִ�в�������
                cmd_clsx_insert.ExecuteNonQuery();
				
				//��ȫ�������Ա�			
		        string str_clsx_update = "update �������Ա� set clsx_id=(select max(myid) from �������Ա� ), "
				+"cl_id=(select cl_id from ���ϱ� where ��ʾ��='"+cl_name+"'),"
				+"fl_id = (select fl_id from ���Ϸ���� where �������='"+flname+"'),"
				+"��������='"+cl_clflname+"',�������='"+flname+"',���ϱ���='"+flname+"'+' "+cl_clbm+"'+'"+cl_clbh+"', "
				+"��������='"+cl_name+"',��������ֵ����='"+sx_codes+"'+'"+cl_number+"' where ������������='"+cl_flsxmc+"' "
				+"and flsx_id='"+sx_id+"'and flsxz_id='"+cl_ids+"' ";
				SqlCommand cmd_clsx_update= new SqlCommand(str_clsx_update, conn);    //ִ�в�������
                cmd_clsx_update.ExecuteNonQuery();
                conn.Close();    
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