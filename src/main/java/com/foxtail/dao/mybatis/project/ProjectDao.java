package com.foxtail.dao.mybatis.project;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.filter.ProjectFilter;
import com.foxtail.model.project.Project;

public interface ProjectDao {

	void save(@Param("model")Project project);
	
	void update(@Param("model")Project project);
	
	Project getById(@Param("id")String id);
	
	List<Project> findForPage2(@Param("ft")ProjectFilter filter);
}
