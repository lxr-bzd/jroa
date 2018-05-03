package com.foxtail.dao.mybatis.project;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.filter.ProjectFilter;
import com.foxtail.model.project.Project;

public interface ProjectDao {

	void save(@Param("model")Project project);
	
	void update(@Param("model")Project project);
	
	Project getById(@Param("id")String id);
	
	List<Project> findForPage2(@Param("ft")ProjectFilter filter);
	
	void saveProduct(@Param("projectid")String prjectid,@Param("productid")String productid);
	
	
	
	List<Map<String, Object>> findProducts(@Param("projectid")String prjectid);
	
	List<Map<String, Object>> findMebs(@Param("projectid")String prjectid);
	
	void deleteAllProduct(@Param("ids")String[] prjectids);
	
	void deleteAllCollect(@Param("ids")String[] prjectids);
	
	void deleteAllMebs(@Param("ids")String[] prjectids);
	
	
	
	
	
	
	
}

