package com.foxtail.service.customer;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.customer.VisitDao;
import com.foxtail.model.customer.Visit;


@Service
public class VisitService {

	@Autowired
	VisitDao visitDao;
	
	
	public void save(Visit visit) {
		
		visitDao.save(visit);

	}
	
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("cus_visit", ids);

	}
	
	
	public void update(Visit visit) {
	
		visitDao.update(visit);

	}
	
	public Pagination findForPage(Pagination page,String cusid) {
		
		List  list = visitDao.findForPage(page,cusid);
		page.setList(list);
		return page;

	}
	
	
	public Visit getById(String id) {
		
		return visitDao.getById(id);

	}

	
}


