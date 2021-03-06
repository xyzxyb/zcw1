
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
			
            string yh_id = Convert.ToString(Session["yh_id"]);   //获取用户id	
			
            string str_gysxx_type = "select  gys_id from 材料供应商信息表 where  yh_id='"+yh_id+"' ";            
            DataTable dt_gysxxs = objConn.GetDataTable(str_gysxx_type);
            string gys_id = Convert.ToString(dt_gysxxs.Rows[0]["gys_id"]);	  //141 根据用户id 获取供应商id
				

            //新增材料写入数据库
            {
              
                string cl_name = Request["cl_name"];                //材料名称
                string cl_type = Request["cl_type"];                //规格型号              
                string cl_bit = Request["cl_bit"];                  //计量单位
                string cl_volumetric = Request["cl_volumetric"];        //单位体积
				string cl_height = Request["cl_height"];                //单位重量
                string cl_instruction = Request["cl_instruction"];      //说明       
                string brand = Request["brand"];                        //品牌id(获取的是下拉列表中value的值)
                
				
                string str_xzcl = "insert into  材料表(显示名,规格型号,计量单位,单位体积,单位重量,说明,是否启用,pp_id) "
				+"values('" + cl_name + "','"+cl_type+"','" + cl_bit + "','" + cl_volumetric + "', "
				+" '" + cl_height + "','"+cl_instruction+"','1','"+brand+"' ) ";          
                //更新材料表
    objConn.ExecuteSQL(str_xzcl,false);
			    
				//补全材料表信息
				string yjflname = Request["yjflname"];              //大级分类名称 (获取的是下拉列表中value的值 分类编码 两位)              
                string ejflname = Request["ejflname"];              //二级分类名称  (分类编码 4位)
                     
                string flname = ejflname;
                if (flname.Equals("0"))  
				flname = yjflname;
				 DataTable Sdt_cl = new DataTable();
				Sdt_cl = objConn.GetDataTable ("select 分类名称,属性编码,编号 from 材料分类属性值表 where 分类编码='"+flname+"' ");
				
				string cl_clbm = Convert.ToString(dt_cl.Rows[0]["属性编码"]);  //材料编码
				string cl_clbh = Convert.ToString(dt_cl.Rows[0]["编号"]);      //材料编号
				string cl_clflname = Convert.ToString(dt_cl.Rows[0]["分类名称"]);      //分类名称
				
                string cl_update = "update 材料表 set gys_id='"+gys_id+"', "
				+"cl_id= (select myID from 材料表 where 显示名='"+cl_name+"'),"
				+"fl_id = (select fl_id from 材料分类表 where 分类编码='"+flname+"'),"
				+"生产厂商 = (select 供应商 from 材料供应商信息表 where gys_id = '"+gys_id+"'),"
				+"材料编码 ='"+flname+"'+' "+cl_clbm+"'+'"+cl_clbh+"' , 分类编码 = '"+flname+"', 分类名称='"+cl_clflname+"', "
				+"品牌名称=(select 品牌名称 from 品牌字典 where pp_id='"+brand+"' ) where 显示名='"+cl_name+"' ";
            
                int ret =objConn.ExecuteSQLForCount(cl_update,false);	
				
				//获取表单中需要更新材料属性表的变量
				string sx_names = Request["sx_names"];    //获取分类属性名称 (都是下拉列表中value的值为分类属性flsx_id)
				string sx_codes = Request["sx_codes"];    //获取分类属性编码
				string sx_id = Request["sx_id"];          //获取分类属性id
				string cl_value = Request["cl_value"];    //获取分类属性值
				string cl_number = Request["cl_number"];    //获取分类属性值编号
				string cl_ids = Request["cl_ids"];          //获取属性值id
				
                  DataTable dt_flsx = new DataTable();
				dt_flsx = objConn.GetDataTable("select 分类属性名称 from 材料属性表 where flsx_id='"+sx_names+"' ");
				
				
				string cl_flsxmc = Convert.ToString(dt_flsx.Rows[0]["分类属性名称"]);  //分类属性名称
				
				string str_clsx = "insert into  材料属性表(分类属性名称,分类属性编码,flsx_id,分类属性值,分类属性值编号,flsxz_id) "
				+"values('" + cl_flsxmc + "','"+sx_codes+"','" + sx_id + "','" + cl_value + "', "
				+" '" + cl_number + "','"+cl_ids+"' ) "; 
				//更新材料属性表
				 objConn.ExecuteSQL(str_clsx,false);
				
				//补全材料属性表			
		        string str_clsx_update = "update 材料属性表 set clsx_id=(select max(myid) from 材料属性表 ), "
				+"cl_id=(select cl_id from 材料表 where 显示名='"+cl_name+"'),"
				+"fl_id = (select fl_id from 材料分类表 where 分类编码='"+flname+"'),"
				+"分类名称='"+cl_clflname+"',分类编码='"+flname+"',材料编码='"+flname+"'+' "+cl_clbm+"'+'"+cl_clbh+"', "
				+"材料名称='"+cl_name+"',属性属性值编码='"+sx_codes+"'+'"+cl_number+"' where 分类属性名称='"+cl_flsxmc+"' "
				+"and flsx_id='"+sx_id+"'and flsxz_id='"+cl_ids+"' ";
				objConn.ExecuteSQL(str_clsx_update,false);
            }	                    
		
     %>

    <body>
        <p>
        </p>             
        <a href="gysglcl.aspx" style="color: Blue" onclick="clickMe() ">新增材料成功!请返回; </a>
        <script>
            //function clickMe() 
			{
                //window.close();
                //opener.location.reload();
            }
        </script>      

    </body>