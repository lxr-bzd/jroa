package com.foxtail.service.project;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.project.ProjectDao;
import com.foxtail.filter.ProjectFilter;
import com.foxtail.model.project.Project;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


@Service
public class ProjectService {

	@Autowired
	ProjectDao projectDao;
	
	
	public void save(Project project) {
		
		projectDao.save(project);

	}
	
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("prj_project", ids);

	}
	
	
	public void update(Project project) {
	
		projectDao.update(project);

	}
	
	public Pagination findForPage(Pagination page,ProjectFilter filter) {
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)projectDao.findForPage2(filter);
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;
		

	}
	
	
	public Project getById(String id) {
		
		return projectDao.getById(id);

	}

	
}


