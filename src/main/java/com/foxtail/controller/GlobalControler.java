package com.foxtail.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.foxtail.common.page.PaginableFactroy;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.common.page.Pagination;
import com.foxtail.common.web.DataGrid;
import com.foxtail.model.BaseModel;
import com.foxtail.service.GlobalService;
/**
 * 
 * @author Administrator
 *
 */

@Controller
@RequestMapping("global")
public class GlobalControler extends BaseMybatisController{
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	GlobalService globalService;
	
	
	@RequestMapping("t")
	@ResponseBody
	public Object test(Integer limit,Integer offset,String key) {
		
		
		globalService.savetest();
		
		globalService.save(new BaseModel());
		
		return "";
	}
	
	


	
	@RequestMapping("list")
	@ResponseBody
	public Object list(Integer limit,Integer offset,String key) {
		
		if(limit!=null&&limit==-1)
			return JsonResult.getSuccessResult(jdbcTemplate.queryForList("select * from "+key)) ;
			
		
		
	Pagination pagination = PaginableFactroy.getPagination(offset, limit);
		
	pagination.setList(null);
		DataGrid dataGrid = new DataGrid();
	
		dataGrid.setTotal(pagination.getTotalCount());
		dataGrid.setRows(pagination.getList());
		
		return dataGrid;
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String key,String ids) {
	String[] idarray = ids.split(",");
		
		String[] p = new String[idarray.length];
		
		for (int i = 0; i < idarray.length; i++) {
			p[i] = "?";
		}
		
		
		jdbcTemplate.update("delete "+key +" where id in("+join(p, ",")+")", idarray);
	
		return JsonResult.getSuccessResult() ;
		
	}
	
	public static String join( Object[] o , String flag ){  
        StringBuffer str_buff = new StringBuffer();  
        
        for(int i=0 , len=o.length ; i<len ; i++){  
            str_buff.append( String.valueOf( o[i] ) );  
            if(i<len-1)str_buff.append( flag );  
        }  
       
        return str_buff.toString();   
    }  
	
	@RequestMapping("update")

	
	
	
	
	
	
	
	
	
	
	private Object getResult(String name) {
		SqlExcute excute = jdbcTemplate.queryForObject("select * from sys_plan where name = ?", new String[]{name}, SqlExcute.class);

		if("list".equals(excute.getExpect()))
			return jdbcTemplate.queryForList(excute.sql);
		else if("map".equals(excute.getExpect()))
			return jdbcTemplate.queryForMap(excute.sql);
		else if("int".equals(excute.getExpect()))
			return jdbcTemplate.queryForInt(excute.sql);
		
		return null;
		
	}
	

}
