<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Web" %>

<script runat="server"  > 
		
		
                           
               protected void Page_Load(object sender, EventArgs e)
               {  
                    String gys_id = Convert.ToString(Request["gys_id"]);   //��ȡ�����򴩹����Ĺ�Ӧ��id 
                    String yh_id = Convert.ToString(Session["yh_id"]); 	   //��ȡ�����û�id                  

			        string constr = ConfigurationManager.ConnectionStrings["zcw"].ConnectionString;
                    SqlConnection conn = new SqlConnection(constr);
                    conn.Open();
					
					
					
					string str_select = "select count(*) from ��Ӧ����������� where yh_id = '"+yh_id +"'";
					SqlCommand cmd_select = new SqlCommand(str_select, conn);                           
					Object obj_checkexist_gysid = cmd_select.ExecuteScalar();
                    if (obj_checkexist_gysid != null) 
                    {
                        int count = Convert.ToInt32(obj_checkexist_gysid);
                        if (count ==0 )  //����Ĺ�Ӧ�̲�����
                        {        
                            //���²��Ϲ�Ӧ����Ϣ��
                            //String str_updateuser = "update ��Ӧ����������� set yh_id = '"+yh_id +"' where gys_id = '"+gys_id+"'";
                            //SqlCommand cmd_updateuser = new SqlCommand(str_updateuser, conn);         
                            //cmd_updateuser.ExecuteNonQuery();
							
							//�û���֤ͨ��,���Խ�yh_id���빩Ӧ������		             
			                              	
                            string yhid_insert = "insert into ��Ӧ�����������(yh_id) values('"+yh_id+"')";
                   ��       SqlCommand cmd_insert= new SqlCommand(yhid_insert, conn);
				            cmd_insert.ExecuteNonQuery();
					 
					        //��������Ĺ�Ӧ��id ��ѯ��Ӧ����Ϣ ���µ���Ӧ���������
					 
					        string str_gysxx = "select ��Ӧ��,��ҳ,��ַ,�绰,����,dq_id,��ϵ��,��ϵ���ֻ�,��ϵ��QQ,��λ����,��֯�������,��λ���, "
					        +"��������,����������,ע���ʽ�,��ϵ��ַ,�ʱ�,��������,��Ӫ��Χ,ʡ�е������,��ҵ��� from ���Ϲ�Ӧ����Ϣ�� where "
					        +"gys_id='"+gys_id+"' ";
					        SqlDataAdapter da_gysxx = new SqlDataAdapter (str_gysxx,conn);
					        DataSet ds_gysxx = new DataSet();
					        da_gysxx.Fill(ds_gysxx,"���Ϲ�Ӧ����Ϣ��");
					
					        DataTable dt_gysxx = ds_gysxx.Tables[0];
					        string gys_name = Convert.ToString(dt_gysxx.Rows[0]["��Ӧ��"]);
					        string homepage = Convert.ToString(dt_gysxx.Rows[0]["��ҳ"]);
					        string tel = Convert.ToString(dt_gysxx.Rows[0]["�绰"]);
					        string fax = Convert.ToString(dt_gysxx.Rows[0]["����"]);
					        string user_name = Convert.ToString(dt_gysxx.Rows[0]["��ϵ��"]);
					        string user_phone = Convert.ToString(dt_gysxx.Rows[0]["��ϵ���ֻ�"]);
					        string gys_type = Convert.ToString(dt_gysxx.Rows[0]["��λ����"]);
					        string zzjg_number = Convert.ToString(dt_gysxx.Rows[0]["��֯�������"]);
					        string lx_addrass = Convert.ToString(dt_gysxx.Rows[0]["��ϵ��ַ"]);
					        string scope = Convert.ToString(dt_gysxx.Rows[0]["��Ӫ��Χ"]);
							string area = Convert.ToString(dt_gysxx.Rows[0]["��������"]);
					
					 
					        //���¹�Ӧ�������
					        string sql_yhxx = "update  ��Ӧ����������� set updatetime=(select getdate()),gys_id = '"+gys_id+"', "
					        +"��Ӧ��='"+gys_name+"',��ҳ='"+homepage+"',�绰='"+tel+"',����='"+fax+"',��ϵ��='"+user_name+"', "
					        +"��ϵ���ֻ�='"+user_phone+"',��λ����='"+gys_type+"',��֯�������='"+zzjg_number+"',��ϵ��ַ='"+lx_addrass+"',"
					        +"��Ӫ��Χ='"+scope+"',��������='"+area+"',�������='�����' where yh_id='"+yh_id+"' ";
			                SqlCommand cmd_gysbtxx = new SqlCommand(sql_yhxx,conn);
			                int ret = (int)cmd_gysbtxx.ExecuteNonQuery();	
					        conn.Close();
                        }
					    if(count !=0)
					    {
					       Response.Write("����������һ����������,�����ټ�������!");
						   return;
					    }
                                     
                    }
                    
					
					
                    
                    
                    Response.Write("�ù�Ӧ���Ѿ��ɹ���������,�ҷ�������Ա��ʵ�����Ϣ��,�������������ڸ�����,�����ĵȺ�!");
					

               }
	                  
        
    </script>

