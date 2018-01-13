package com.foxtail.service.sys;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foxtail.dao.mybatis.sys.CommonDao;
import com.lxr.commons.exception.ApplicationException;

@Service
public class CommonService {

	@Autowired
	CommonDao commonDao;
	
	
	public void delete(String table,String[] ids) {
		
		if(!commonDao.delete(table,ids))
			throw new ApplicationException("删除0条记录");

	}
	
	
	
}
