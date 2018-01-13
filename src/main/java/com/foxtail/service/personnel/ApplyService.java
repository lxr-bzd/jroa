package com.foxtail.service.personnel;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.personnel.ApplyDao;
import com.foxtail.filter.ApplyFilter;
import com.foxtail.model.personnel.Apply;


@Service
public class ApplyService {

	@Autowired
	ApplyDao applyDao;
	
	
	public void save(Apply apply) {
		
		applyDao.save(apply);

	}
	
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("man_apply", ids);

	}
	
	
	public void update(Apply apply) {
	
		applyDao.update(apply);

	}
	
	public Pagination findForPage(Pagination page,ApplyFilter filter) {
		
		List  list = applyDao.findForPage(page,filter);
		page.setList(list);
		return page;

	}
	
	
	public Apply getById(String id) {
		
		return applyDao.getById(id);

	}

	
}


