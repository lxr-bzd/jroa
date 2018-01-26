package com.foxtail.dao.mybatis.project;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.project.PrjProgress;

public interface PrjProgressDao {

	void save(@Param("model")PrjProgress prjProgress);
	
	void update(@Param("model")PrjProgress prjProgress);
	
	PrjProgress getById(@Param("id")String id);
	
	List<PrjProgress> findForPage2(String prjid);
}

