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
	
	List<Place> findForPage2(@Param("deptids")String[] deptids,@Param("kw")String kw);
	
	List<Place> findByDeptid(@Param("deptid")String deptid);
	
	int empCount(@Param("ids")String[] ids);
	
	String[] findRoleidsByIds(@Param("ids")String[] ids);
}
