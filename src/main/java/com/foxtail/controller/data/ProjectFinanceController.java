package com.foxtail.controller.data;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.foxtail.common.AppModelMap;
import com.foxtail.common.DataGridResult;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.service.data.StatisticsService;


@Controller
@RequestMapping("data/finance/project")
@AppModelMap("部门")
public class ProjectFinanceController extends BaseMybatisController{

	
	@Autowired
	StatisticsService statisticsService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String sysType,HttpServletRequest request) {
		
		
			return JsonResult.getSuccessResult(statisticsService.statisticsPrj());
		
	}
	
	
	
	
}
