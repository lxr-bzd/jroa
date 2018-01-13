package com.foxtail.dao.mybatis.personnel;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.foxtail.common.page.Pagination;
import com.foxtail.model.personnel.Level;
import com.foxtail.model.personnel.Place;

public interface PlaceDao {

	void save(@Param("model")Place model);
	
	void update(@Param("model")Place dept);
	
	Place getById(@Param("id")String id);
	
	List<Place> findForPage(@Param("page")Pagination page,@Param("deptid")String deptid);
	
	List<Place> findByDeptid(@Param("deptid")String deptid);
	
	int levelCount(@Param("ids")String[] ids);
	
	String[] findRoleidsByIds(@Param("ids")String[] ids);
}
