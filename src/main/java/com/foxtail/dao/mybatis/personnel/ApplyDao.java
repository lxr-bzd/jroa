package com.foxtail.dao.mybatis.personnel;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.common.page.Pagination;
import com.foxtail.filter.ApplyFilter;
import com.foxtail.model.personnel.Apply;

public interface ApplyDao {

	void save(@Param("model")Apply apply);
	
	void saveVouchers(@Param("applyid")String applyid,@Param("files")String[] files);
	
	void deleteVouchers(@Param("ids")String[] ids);
	
	String[] findVouchers(@Param("applyid")String applyid);
	
	void update(@Param("model")Apply apply);
	
	Apply getById(@Param("id")String id);
	
	List<Apply> findForPage2(@Param("ft")ApplyFilter filter);
}

