package com.foxtail.dao.mybatis.personnel;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.model.personnel.Level;

public interface LevelDao {

	void save(@Param("model")Level level);
	
	void update(@Param("model")Level level);
	
	Level getById(@Param("id")String id);
	
	List<Level> findForPage(@Param("page")Pagination page,@Param("kw")String kw);
	
/*	List<Level> findByPlaceid(@Param("placeid")String placeid);*/
	
	int empCount(@Param("ids")String[] ids);
}

