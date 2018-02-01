package com.foxtail.dao.mybatis.project;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.project.Progress;

public interface ProgressDao {

	void save(@Param("model")Progress progress);
	
	void update(@Param("model")Progress progress);
	
	Progress getById(@Param("id")String id);
	
	List<Progress> findForPage2();
	
	int countProject(@Param("ids")String[] ids);
	
}

