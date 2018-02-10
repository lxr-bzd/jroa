package com.foxtail.dao.mybatis.personnel;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.filter.ApplyFilter;
import com.foxtail.model.personnel.Examine;

public interface ExamineDao {

	void save(@Param("model")Examine examine);
	
	void update(@Param("model")Examine examine);
	
	Examine getById(@Param("id")String id);
	
	List<Examine> findForPage(@Param("page")Pagination page,@Param("ft")ApplyFilter filter);
}

