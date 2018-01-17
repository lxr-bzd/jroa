package com.foxtail.dao.mybatis.admin;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.admin.WorkReport;

public interface WorkReportDao {

	void save(@Param("model")WorkReport workReport);
	
	void update(@Param("model")WorkReport workReport);
	
	WorkReport getById(@Param("id")String id);
	
	List<WorkReport> findForPage2();
}

