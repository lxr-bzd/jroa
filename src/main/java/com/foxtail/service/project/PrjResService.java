package com.foxtail.service.project;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.project.PrjResDao;
import com.foxtail.model.project.PrjRes;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


@Service
public class PrjResService {

	@Autowired
	PrjResDao prjResDao;
	
	
	public void save(PrjRes prjRes) {
		
		prjResDao.save(prjRes);

	}
	
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("prj_res", ids);

	}
	
	
	public void update(PrjRes prjRes) {
	
		prjResDao.update(prjRes);

	}
	
	public Pagination findForPage(Pagination page,String kw) {
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)prjResDao.findForPage2(kw);
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;
		

	}
	
	
	public PrjRes getById(String id) {
		
		return prjResDao.getById(id);

	}

	
}


