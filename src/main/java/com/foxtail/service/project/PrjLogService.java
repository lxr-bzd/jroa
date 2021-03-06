package com.foxtail.service.project;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.project.PrjLogDao;
import com.foxtail.model.project.PrjLog;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


@Service
public class PrjLogService {

	@Autowired
	PrjLogDao prjLogDao;
	
	
	public void save(PrjLog prjLog) {
		
		prjLogDao.save(prjLog);

	}
	
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("prj_Log", ids);

	}
	
	
	public void update(PrjLog prjLog) {
	
		prjLogDao.update(prjLog);
	}
	
	public Pagination findForPage(Pagination page,String prjid) {
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)prjLogDao.findForPage2(prjid);
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;
		

	}
	
	
	public PrjLog getById(String id) {
		
		return prjLogDao.getById(id);

	}

	
}


