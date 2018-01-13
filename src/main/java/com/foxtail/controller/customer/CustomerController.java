package com.foxtail.controller.customer;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foxtail.bean.ServiceManager;
import com.foxtail.common.AppModelMap;
import com.foxtail.common.DataGridResult;
import com.foxtail.common.JsonResult;
import com.foxtail.common.base.BaseMybatisController;
import com.foxtail.filter.CustomerFilter;
import com.foxtail.model.customer.Customer;
import com.foxtail.service.customer.CustomerService;


@Controller
@RequestMapping("customer/customer/customer")
@AppModelMap("部门")
public class CustomerController extends BaseMybatisController{

	@Autowired
	CustomerService customerService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(sysAction))
		modelMap.put("vo", customerService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String type,CustomerFilter filter,HttpServletRequest request) {
		
		if("info".equals(type))
			return JsonResult.getSuccessResult(customerService.getById(request.getParameter("id")));
		else 
		return DataGridResult.getResult(customerService.findForPage(getPagination(request),filter));
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
	public Object update(Customer customer) {
		
		customerService.update(customer);

		return JsonResult.getSuccessResult();
	}
	
}
