package com.foxtail.dao.mybatis.project;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.project.PrjLog;

public interface PrjLogDao {

	void save(@Param("model")PrjLog prj);
	
	void update(@Param("model")PrjLog prj);
	
	PrjLog getById(@Param("id")String id);
	
	List<PrjLog> findForPage2(String prjid);
}

