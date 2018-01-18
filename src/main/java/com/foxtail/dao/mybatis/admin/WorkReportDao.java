package com.foxtail.dao.mybatis.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.filter.WorkReportFilter;
import com.foxtail.model.admin.ReportDetail;
import com.foxtail.model.admin.ReportExamine;
import com.foxtail.model.admin.WorkReport;

public interface WorkReportDao {

	void save(@Param("model")WorkReport workReport);
	
	void update(@Param("model")WorkReport workReport);
	void updateByCustom(@Param("model")WorkReport workReport);
	
	WorkReport getById(@Param("id")String id);
	
	List<WorkReport> findForPage2(@Param("ft")WorkReportFilter filter);
	
	void saveExamine(@Param("model")ReportExamine examine);
	
	void saveDetail(@Param("model")ReportDetail map);
	
	ReportDetail[] getDetail(@Param("reportid")String reportid);
	
	void deleteDetail(@Param("reportids")String[] reportids);
}

