package com.foxtail.controller.data;

import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.foxtail.common.AppModelMap;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.common.util.DateUtils;
import com.foxtail.service.data.StatisticsService;


@Controller
@RequestMapping("data/finance/emp")
@AppModelMap("部门")
public class EmpFinanceController extends BaseMybatisController{


	@Autowired
	StatisticsService statisticsService;
	
	
	@RequestMapping()  
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(HttpServletRequest request) { 
		Integer month = Calendar.getInstance().get(Calendar.MONTH)+1; 
		return JsonResult.getSuccessResult(statisticsService.statisticsEmp( month));
	
	}

}
