package com.foxtail.service.project;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.project.ProjectDao;
import com.foxtail.filter.ProjectFilter;
import com.foxtail.model.project.PrjCollect;
import com.foxtail.model.project.Project;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


@Service
public class ProjectService {

	@Autowired
	ProjectDao projectDao;
	@Autowired
	PrjCollectService prjCollectService;
	
	
	public void save(Project project) {
		
		projectDao.save(project);
		if(project.getProductids()!=null)
		for (String id : project.getProductids()) {
			projectDao.saveProduct(project.getId(), id);
		}
		
		if(project.getReceived()==null||project.getReceived()<=0)return;

		PrjCollect prjCollect = new PrjCollect();
		prjCollect.setEmpid(project.getOrderempid());
		prjCollect.setMoney(project.getReceived());
		prjCollect.setPrjid(project.getId());
		prjCollect.setTime(System.currentTimeMillis());
		
		prjCollectService.save(prjCollect);

	}
	
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("prj_project", ids);
		projectDao.deleteAllProduct(ids);
	}
	
	
	public void update(Project project) {
	
		projectDao.update(project);
		projectDao.deleteAllProduct(new String[] {project.getId()}); 
		if(project.getProductids()!=null)
			for (String id : project.getProductids()) {
				projectDao.saveProduct(project.getId(), id);
		}
	}
	
	public Pagination findForPage(Pagination page,ProjectFilter filter) {
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)projectDao.findForPage2(filter);
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;
		

	}
	
	
	public Project getById(String id) {
		
		Project project = projectDao.getById(id);
		project.setProducts(projectDao.findProducts(id));
		return project;
	}

	
}


