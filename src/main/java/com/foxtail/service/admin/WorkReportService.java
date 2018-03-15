package com.foxtail.service.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.admin.WorkReportDao;
import com.foxtail.filter.WorkReportFilter;
import com.foxtail.model.admin.ReportDetail;
import com.foxtail.model.admin.ReportExamine;
import com.foxtail.model.admin.WorkReport;
import com.foxtail.service.personnel.DeptService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.lxr.commons.exception.ApplicationException;


@Service
public class WorkReportService {

	@Autowired
	WorkReportDao workReportDao;
	
	@Autowired
	DeptService deptService;
	
	public void save(WorkReport workReport) {
		
		workReportDao.save(workReport);
	}
	
	public void delete(String[] ids) {
		if(workReportDao.countValid(ids)>0)throw new ApplicationException("存在已生效记录");
		ServiceManager.commonService.delete("adm_work_report", ids);
		workReportDao.deleteDetail(ids);
		workReportDao.deleteExamine(ids);

	}
	
	
	public void update(WorkReport workReport) {
		if(workReportDao.countValid(new String[]{workReport.getId()})>0)throw new ApplicationException("已生效记录不能修改");
		workReportDao.update(workReport);
		

	}
	
	public Pagination findForPage(Pagination page,WorkReportFilter filter) {
		
		switch (filter.getSysView()) {
		
		case "all":
			filter.setUid(null);
			filter.setUdeptids(null);
			break;
		case "below":filter.setUdeptids(deptService.findBelowIds(filter.getDeptid()));
		break;
		
		case "def":
		default:filter.setUdeptids(null);
			break;
		}
		
		
		PageHelper.startPage(page.getPageNo(), page.getPageSize());
		Page listCountry  = (Page)workReportDao.findForPage2(filter);
		page.setTotalCount((int)listCountry.getTotal());
		page.setList(listCountry.getResult());
		return page;

	}
	
	
	public WorkReport getById(String id) {
		
		WorkReport report = workReportDao.getById(id);
		if(report.getType()==2)report.setDetails(workReportDao.getDetail(report.getId()));

		return report;
	}
	
	public void doExamine(ReportExamine examine) {
		Integer state = getById(examine.getReportid()).getReport_state();
		if(state==2)throw new ApplicationException("重复审核!");
		
		WorkReport report = new WorkReport();
		report.setId(examine.getReportid());
		report.setReport_state(2);
		report.setExamineid(examine.getTheid());
		report.setExaminetime(System.currentTimeMillis());
		workReportDao.updateByCustom(report);
		
		workReportDao.saveExamine(examine);
	}

	
	private void saveDetails(ReportDetail[] details,String reportid) {
		for (ReportDetail detail : details) {
			detail.setReportid(reportid);
			workReportDao.saveDetail(detail);
		}

	}
	
}


