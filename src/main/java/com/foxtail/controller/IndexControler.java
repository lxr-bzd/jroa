package com.foxtail.controller;

import org.apache.commons.lang.time.DateUtils;
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
import com.foxtail.service.IndexService;
/**
 * 
 * @author Administrator
 *
 */

@Controller
@RequestMapping("index")
public class IndexControler extends BaseMybatisController{
	
	@Autowired
	JdbcTemplate jdbcTemplate;
	
	
	@Autowired
	IndexService indexService;
	
	
	@RequestMapping("statistics")
	@ResponseBody
	public Object statistics() {
		
		return JsonResult.getSuccessResult(indexService.getStatistics());
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
