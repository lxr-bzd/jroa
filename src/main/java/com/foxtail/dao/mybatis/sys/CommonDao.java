package com.foxtail.dao.mybatis.sys;

import org.apache.ibatis.annotations.Param;


public interface CommonDao {
	
	boolean delete(@Param("table")String table,@Param("ids")String[] ids);

}
