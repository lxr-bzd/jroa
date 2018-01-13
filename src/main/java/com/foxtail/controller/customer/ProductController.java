package com.foxtail.controller.customer;

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
import com.foxtail.model.customer.Product;
import com.foxtail.service.customer.ProductService;


@Controller
@RequestMapping("customer/customer/product")
@AppModelMap("部门")
public class ProductController extends BaseMybatisController{

	@Autowired
	ProductService productService;
	
	
	@RequestMapping() 
	public String toMain(String sysModule){
		return getMainJsp(sysModule);
	}
	
	
	@RequestMapping("toedit") 
	public String toEdit(String sysAction,String id,ModelMap modelMap){
		String jsp= getEditJsp();
		
		if("edit".equals(sysAction))
		modelMap.put("vo", productService.getById(id));
		return jsp;
	}
	
	
	
	@RequestMapping("view")
	@ResponseBody
	public Object view(String type,HttpServletRequest request) {
		
		if("info".equals(type))
			return JsonResult.getSuccessResult(productService.getById(request.getParameter("id")));
		else 
		return DataGridResult.getResult(productService.findForPage(getPagination(request)));
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Object save(Product product) {
		
		productService.save(product);

		return JsonResult.getSuccessResult();
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public Object delete(String ids) {
		
		productService.delete(ids.split(","));

		return JsonResult.getSuccessResult();
	}
	
	
	@RequestMapping("update")
	@ResponseBody
	public Object update(Product product) {
		
		productService.update(product);

		return JsonResult.getSuccessResult();
	}
	
}
