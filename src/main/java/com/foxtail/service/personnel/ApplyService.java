package com.foxtail.service.personnel;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.personnel.ApplyDao;
import com.foxtail.filter.ApplyFilter;
import com.foxtail.model.personnel.Apply;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


@Service
public class ApplyService {

	@Autowired
	ApplyDao applyDao;
	
	
	@Autowired
	DeptService deptService;
	
	
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
		
		switch (filter.getSysView()) {
		case "def":
		case "all":filter.setDeptids(null);
			break;
		case "below":filter.setDeptids(deptService.findBelowIds(filter.getUdeptid()));
		break;
		
		default:filter.setDeptids(new String[]{"-1"});
			break;
		} 
		
		
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)applyDao.findForPage2(filter);
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;

	}
	
	
	public Apply getById(String id) {
		
		return applyDao.getById(id);

	}

	
}


