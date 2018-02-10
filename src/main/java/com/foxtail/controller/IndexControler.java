package com.foxtail.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
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
	
	 
	
	@RequestMapping("sale")
	@ResponseBody
	public Object getResult(Long starttime,Long endtime) {
		
		return JsonResult.getSuccessResult(indexService.findSale(starttime, endtime));
		
	}
	
	
	
	

}
