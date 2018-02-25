package com.foxtail.controller.customer;


import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSONObject;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.AppModelMap;
import com.foxtail.common.DataGridResult;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.filter.CustomerFilter;
import com.foxtail.filter.WorkReportFilter;
import com.foxtail.model.customer.Customer;
import com.foxtail.service.customer.CustomerService;
import com.foxtail.service.personnel.EmpService;


@Controller
@RequestMapping("customer/customer/customer")
@AppModelMap("部门")
public class CustomerController extends BaseMybatisController{

	@Autowired
	CustomerService customerService;
	
	@Autowired
	EmpService empService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(sysAction)) {
			Customer customer = customerService.getById(id);
			modelMap.put("vo", customer);
			modelMap.put("productsJson", JSONObject.toJSONString(customer.getProducts()));
		}
		
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String type,CustomerFilter filter,String deptStr,HttpServletRequest request) {
		
		if("info".equals(type))
			return JsonResult.getSuccessResult(customerService.getById(request.getParameter("id")));
		else {
			if(!StringUtils.isEmpty(deptStr))
			filter.setDeptids(deptStr.split(","));
			
			resolveSysView(filter);
			filter.setEmpid(ServiceManager.securityService.getUid());
			filter.setUdeptids(new String[] {empService.getById(ServiceManager.securityService.getUid()).getDeptid()});
			
			return DataGridResult.getResult(customerService.findForPage(getPagination(request),filter));
		}
		
	}
	
	
	 private void resolveSysView(CustomerFilter filter) {
		 filter.setSysView("def");
		 if(SecurityUtils.getSubject().isPermitted("customer/customer/customer?$sysView=all")) {
			 filter.setSysView("all");
			 return ;
		 }
		 if(SecurityUtils.getSubject().isPermitted("customer/customer/customer?$sysView=below")) {
				filter.setSysView("below");
			 
		 }
		 
		

	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(Customer customer) {
		customer.setEmpid(ServiceManager.securityService.getUid());
		
		customerService.save(customer);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		customerService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(String sysType,Customer customer) {
		
		
		customerService.update(customer,sysType);

		return JsonResult.getSuccessResult();
	}
	
}
