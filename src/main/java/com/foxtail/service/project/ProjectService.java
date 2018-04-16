package com.foxtail.service.project;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.project.PrjCollectDao;
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
		if(project.getMebs()!=null&&project.getMebs().size()>0)
		projectDao.saveMebs(project.getId(),project.getMebs());
		
		if(project.getReceived()==null||project.getReceived()<=0)return;

		PrjCollect prjCollect = new PrjCollect();
		prjCollect.setType(1);
		prjCollect.setEmpid(project.getOrderempid());
		prjCollect.setMoney(project.getReceived());
		prjCollect.setPrjid(project.getId());
		prjCollect.setTime(System.currentTimeMillis());
		
		prjCollectService.save(prjCollect);

	}
	
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("prj_project", ids);
		projectDao.deleteAllProduct(ids);
		projectDao.deleteAllCollect(ids);
		
	}
	
	
	public void update(Project project) {
	
		projectDao.update(project);
		projectDao.deleteAllProduct(new String[] {project.getId()}); 
		if(project.getProductids()!=null)
			for (String id : project.getProductids()) {
				projectDao.saveProduct(project.getId(), id);
		}
		projectDao.deleteAllMebs(new String[] {project.getId()});
		if(project.getMebs()!=null&&project.getMebs().size()>0)
		projectDao.saveMebs(project.getId(), project.getMebs());
	}
	
	public Pagination findForPage(Pagination page,ProjectFilter filter) {
		
		switch (filter.getSysView()) {
		
		case "below":
			filter.setUid(null);
			filter.setUid2(filter.getUid());
			filter.setUdeptids(new String[] {filter.getDeptid()});
			break;
		case "all":
			filter.setUdeptids(null);
			filter.setUid(null);
			break;
		case "def":
			filter.setUdeptids(null);
		default:
			break;
		}
		
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)projectDao.findForPage2(filter);
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;
		

	}
	
	
	public Project getById(String id) {
		
		Project project = projectDao.getById(id);
		project.setProducts(projectDao.findProducts(id));
		project.setMebs(projectDao.findMebs(id));
		return project;
	}

	
}


