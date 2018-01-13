package com.foxtail.service.customer;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.customer.ProductDao;
import com.foxtail.model.customer.Product;
import com.lxr.commons.exception.ApplicationException;


@Service
public class ProductService {

	@Autowired
	ProductDao productDao;
	
	
	public void save(Product product) {
		
		productDao.save(product);

	}
	
	
	
	
	public void delete(String[] ids) {
		
		if(productDao.customerCount(ids)>0)
			throw new ApplicationException("存在关联客户，不能删除");
		
		ServiceManager.commonService.delete("cus_product", ids);

	}
	
	
	public void update(Product product) {
	
		productDao.update(product);

	}
	
	public Pagination findForPage(Pagination page) {
		
		List  list = productDao.findForPage(page);
		page.setList(list);
		return page;

	}
	
	
	public Product getById(String id) {
		
		return productDao.getById(id);

	}

	
}


