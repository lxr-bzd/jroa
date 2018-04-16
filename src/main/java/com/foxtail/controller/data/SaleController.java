package com.foxtail.controller.data;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
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
@RequestMapping("data/finance/sale")
@AppModelMap("部门")
public class SaleController extends BaseMybatisController{

	@Autowired
	StatisticsService statisticsService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	

	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(HttpServletRequest request,String year) {
		Date tyear = Calendar.getInstance().getTime();
		try {
			if(!StringUtils.isEmpty(year)) {
				Calendar cal = Calendar.getInstance();
				cal.set(Integer.parseInt(year), 1, 1);
				tyear = cal.getTime();
			}
		} catch (Exception e) {
		}
		
		Long start = DateUtils.getSpecficYearStart(tyear, 0).getTime();
		Long end = DateUtils.getSpecficYearEnd(tyear, 0).getTime();
		
		Map<String, Object> group = new HashMap<>();
		group.put("cuss", statisticsService.findYearEmp(start, end));
		group.put("prjs", statisticsService.findYearPrj(start, end));
		group.put("cyear", Calendar.getInstance().get(Calendar.YEAR));
		return JsonResult.getSuccessResult(group);
	
	}
	
	

	
	
	

}
