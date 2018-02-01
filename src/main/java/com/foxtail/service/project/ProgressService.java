package com.foxtail.service.project;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.project.ProgressDao;
import com.foxtail.model.project.Progress;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.lxr.commons.exception.ApplicationException;


@Service
public class ProgressService {

	@Autowired
	ProgressDao progressDao;
	
	
	public void save(Progress progress) {
		
		progressDao.save(progress);

	}
	
	
	
	
	public void delete(String[] ids) {
		if(progressDao.countProject(ids)>0)
		throw new ApplicationException("存在关联项目，不能删除！");
		ServiceManager.commonService.delete("prj_progress", ids);

	}
	
	
	public void update(Progress progress) {
	
		progressDao.update(progress);

	}
	
	public Pagination findForPage(Pagination page) {
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)progressDao.findForPage2();
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;
		

	}
	
	
	public Progress getById(String id) {
		
		return progressDao.getById(id);

	}

	
}


