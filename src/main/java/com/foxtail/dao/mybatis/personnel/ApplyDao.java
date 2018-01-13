package com.foxtail.dao.mybatis.personnel;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.filter.ApplyFilter;
import com.foxtail.model.personnel.Apply;

public interface ApplyDao {

	void save(@Param("model")Apply apply);
	
	void update(@Param("model")Apply apply);
	
	Apply getById(@Param("id")String id);
	
	List<Apply> findForPage(@Param("page")Pagination page,@Param("ft")ApplyFilter filter);
}

