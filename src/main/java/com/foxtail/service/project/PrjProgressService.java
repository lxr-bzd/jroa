package com.foxtail.service.project;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.project.PrjProgressDao;
import com.foxtail.model.project.PrjProgress;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


@Service
public class PrjProgressService {

	@Autowired
	PrjProgressDao prjProgressDao;
	
	
	public void save(PrjProgress prjProgress) {
		
		prjProgressDao.save(prjProgress);

	}
	
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("prj_progress", ids);

	}
	
	
	public void update(PrjProgress prjProgress) {
	
		prjProgressDao.update(prjProgress);
	}
	
	public Pagination findForPage(Pagination page,String prjid) {
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)prjProgressDao.findForPage2(prjid);
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;
		

	}
	
	
	public PrjProgress getById(String id) {
		
		return prjProgressDao.getById(id);

	}

	
}


