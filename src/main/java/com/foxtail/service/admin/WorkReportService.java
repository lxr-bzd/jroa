package com.foxtail.service.admin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.foxtail.bean.ServiceManager;
import com.foxtail.common.page.Pagination;
import com.foxtail.dao.mybatis.admin.WorkReportDao;
import com.foxtail.filter.WorkReportFilter;
import com.foxtail.model.admin.ReportDetail;
import com.foxtail.model.admin.ReportExamine;
import com.foxtail.model.admin.WorkReport;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;


@Service
public class WorkReportService {

	@Autowired
	WorkReportDao workReportDao;
	
	
	public void save(WorkReport workReport) {
		
		workReportDao.save(workReport);
		if(workReport.getType()==null)return;
		if(workReport.getType()==2)
			saveDetails(workReport.getDetails(), workReport.getId());
		

	}
	
	public void delete(String[] ids) {
		
		ServiceManager.commonService.delete("adm_work_report", ids);

	}
	
	
	public void update(WorkReport workReport) {
	
		workReportDao.update(workReport);
		if(workReport.getType()==null)return;
		if(workReport.getType()==2) {
			workReportDao.deleteDetail(new String[]{workReport.getId()});
			saveDetails(workReport.getDetails(), workReport.getId());
			
		}

	}
	
	public Pagination findForPage(Pagination page,WorkReportFilter filter) {
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


