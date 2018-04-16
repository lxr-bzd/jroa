package com.foxtail.service.personnel;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.druid.sql.visitor.functions.If;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.personnel.ApplyDao;
import com.foxtail.dao.mybatis.personnel.ExamineDao;
import com.foxtail.filter.ApplyFilter;
import com.foxtail.model.personnel.Apply;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


@Service
public class ApplyService {

	@Autowired
	ApplyDao applyDao;
	
	@Autowired
	ExamineDao examineDao;
	
	
	@Autowired
	DeptService deptService;
	
	
	public void save(Apply apply) {
		applyDao.save(apply);
		if(apply.getVouchers()==null||apply.getVouchers().length<1)return;
		applyDao.saveVouchers(apply.getId(),apply.getVouchers());
	}
	
	
	
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("man_apply", ids);
		applyDao.deleteVouchers(ids);
		examineDao.deleteByApplyids(ids);
	}
	
	
	public void update(Apply apply) {
		applyDao.deleteVouchers(new String[] {apply.getId()});
		applyDao.update(apply);
		if(apply.getVouchers()!=null&&apply.getVouchers().length>0)
		applyDao.saveVouchers(apply.getId(), apply.getVouchers());

	}
	
	public Pagination findForPage(Pagination page,ApplyFilter filter) {
		
		switch (filter.getSysView()) {
		case "self":filter.setUdeptids(null);
		break;
		case "all":filter.setUdeptids(null);
			break;
		case "below":filter.setUdeptids(deptService.findBelowIds(filter.getUdeptid()));
		break;
		
		case "def":
		default:filter.setUdeptids(null);filter.setUid("-1");
			break;
		} 
		
		
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)applyDao.findForPage2(filter);
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;

	}
	
	
	public Apply getById(String id) {
		
		Apply apply = applyDao.getById(id);
		apply.setVouchers(applyDao.findVouchers(id));
		return apply;
	}

	
}


