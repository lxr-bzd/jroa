package com.foxtail.dao.mybatis.project;

import java.util.Map;
import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.foxtail.model.project.PrjMeb;

public interface PrjMebDao {
	
	void deleteDevElse(@Param("prjid")String prjid,@Param("uids")String [] uids);
	
	List<PrjMeb> findAll(@Param("prjid")String prjid);
	
	void setAlltime(@Param("uid")String uid,@Param("prjid")String prjid,@Param("alltime")Double alltime);

	Map<String, Object> getPrjMeb(@Param("prjid")String prjid,@Param("uid")String uid);
	
	void updateMeb(Map<String, Object> map);
	
	void saveMebs(@Param("prjid")String prjid,@Param("mebs")List<PrjMeb> list);
	
}
