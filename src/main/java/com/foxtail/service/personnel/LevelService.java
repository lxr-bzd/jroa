package com.foxtail.service.personnel;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.personnel.LevelDao;
import com.foxtail.model.personnel.Level;
import com.lxr.commons.exception.ApplicationException;


@Service
public class LevelService {

	@Autowired
	LevelDao levelDao;
	
	
	public void save(Level level) {
		
		levelDao.save(level);

	}
	
	
	public void delete(String[] ids) {

		if(levelDao.empCount(ids)>0)
			throw new ApplicationException("存在关联员工，不能删除！");
		ServiceManager.commonService.delete("man_level", ids);
	}
	
	
	public void update(Level level) {
		levelDao.update(level);
	}
	
	public Pagination findForPage(Pagination page,String kw) {
		
		List  list = levelDao.findForPage(page,kw);
		page.setList(list);
		return page;

	}
	
	
	public Level getById(String id) {
		
		return levelDao.getById(id);

	}
	
/*	public List<Level> findByPlaceid(String placeid) {
		
		return levelDao.findByPlaceid(placeid);

	}*/

	
}


