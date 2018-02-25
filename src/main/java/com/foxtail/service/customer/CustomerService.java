package com.foxtail.service.customer;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.customer.CustomerDao;
import com.foxtail.dao.mybatis.customer.ProductDao;
import com.foxtail.filter.CustomerFilter;
import com.foxtail.model.customer.Customer;
import com.foxtail.model.customer.Product;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


@Service
public class CustomerService {

	@Autowired
	CustomerDao customerDao;
	
	@Autowired
	ProductDao productDao;
	
	
	public void save(Customer customer) {
		
		customerDao.save(customer);
		
		if(customer.getProductids()==null)return;
		
		for (String pid : customer.getProductids()) {
			if(StringUtils.isEmpty(pid))continue;
			customerDao.saveProduct(customer.getId(), pid);
		}
		

	}
	
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("cus_customer", ids);

	}
	
	
	public void update(Customer customer,String type) {
		
		if("custom".equals(type)) {
			customerDao.updateByCustom(customer);
			return;
		}
		
	
		customerDao.update(customer);
		
		customerDao.deleteAllProduct(customer.getId());
		
		if(customer.getProductids()==null)return;
		
		for (String pid : customer.getProductids()) {
			if(StringUtils.isEmpty(pid))continue;
			customerDao.saveProduct(customer.getId(), pid);
		}
		

	}
	
	public Pagination findForPage(Pagination page,CustomerFilter filter) {
		switch (filter.getSysView()) {
		
		case "all":filter.setEmpid(null);
		filter.setUdeptids(null);
		break;
		case "below":
			filter.setEmpid(null);
		break;
		case "def":
		default:filter.setDeptids(new String[] {"-1"});
			break;
		}
		
		
		
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)customerDao.findForPag(page,filter,filter.getDeptids());
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;

	}
	
	
	public Customer getById(String id) {
		
		Customer customer = customerDao.getById(id);
		
		customer.setProducts(productDao.findByCus(customer.getId()));
		
		return customer;

	}

	
}


