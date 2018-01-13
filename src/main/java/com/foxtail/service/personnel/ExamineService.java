package com.foxtail.service.personnel;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.personnel.ExamineDao;
import com.foxtail.model.personnel.Examine;


@Service
public class ExamineService {

	@Autowired
	ExamineDao examineDao;
	
	
	public void save(Examine examine) {
		
		examineDao.save(examine);

	}
	
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("man_examine", ids);

	}
	
	
	public void update(Examine examine) {
	
		examineDao.update(examine);

	}
	
	public Pagination findForPage(Pagination page) {
		
		List  list = examineDao.findForPage(page);
		page.setList(list);
		return page;

	}
	
	
	public Examine getById(String id) {
		
		return examineDao.getById(id);

	}

	
}


