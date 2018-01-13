package com.foxtail.dao.mybatis.personnel;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.foxtail.model.personnel.Dept;

public interface DeptDao {

	void save(@Param("model")Dept model);
	
	void update(@Param("model")Dept dept);
	
	void delete(@Param("ids")String[] ids);
	
	Dept getByid(@Param("id")String id);
	
	List<Dept> findAll();
	
	//根据父id查询
	List<String> findByParentid(@Param("pid")String pid);
	
	//查询关联职位数
	int placeCount(@Param("ids")String[] ids);
	
	
	
}
