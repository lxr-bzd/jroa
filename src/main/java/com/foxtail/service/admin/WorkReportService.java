package com.foxtail.service.admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.admin.WorkReportDao;
import com.foxtail.model.admin.WorkReport;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


@Service
public class WorkReportService {

	@Autowired
	WorkReportDao workReportDao;
	
	
	public void save(WorkReport workReport) {
		
		workReportDao.save(workReport);

	}
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("adm_work_report", ids);

	}
	
	
	public void update(WorkReport workReport) {
	
		workReportDao.update(workReport);

	}
	
	public Pagination findForPage(Pagination page) {
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)workReportDao.findForPage2();
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;
		

	}
	
	
	public WorkReport getById(String id) {
		
		return workReportDao.getById(id);

	}

	
}


