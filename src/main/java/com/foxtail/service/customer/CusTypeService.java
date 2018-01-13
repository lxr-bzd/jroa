package com.foxtail.service.customer;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.customer.CusTypeDao;
import com.foxtail.model.customer.CusType;
import com.lxr.commons.exception.ApplicationException;


@Service
public class CusTypeService {

	@Autowired
	CusTypeDao cusTypeDao;
	
	
	public void save(CusType cusType) {
		
		
		
		cusTypeDao.save(cusType);

	}
	
	
	
	
	public void delete(String[] ids) {
		
		if(cusTypeDao.countCus(ids)>0)throw new ApplicationException("存在关联客户,不能删除");
		
		ServiceManager.commonService.delete("cus_type", ids);

	}
	
	
	public void update(CusType cusType) {
	
		cusTypeDao.update(cusType);

	}
	
	public Pagination findForPage(Pagination page) {
		
		List  list = cusTypeDao.findForPage(page);
		page.setList(list);
		return page;

	}
	
	public List findAll() {
		
		List  list = cusTypeDao.findAll();
		
		return list;

	}
	
	
	public CusType getById(String id) {
		
		return cusTypeDao.getById(id);

	}

	
}


